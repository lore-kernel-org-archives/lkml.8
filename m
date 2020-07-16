Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69CFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABDA20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgGPNlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:41:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49244 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgGPNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:41:19 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06GDfHDn085146;
        Thu, 16 Jul 2020 22:41:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Thu, 16 Jul 2020 22:41:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06GDfGUv085143
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 16 Jul 2020 22:41:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] binder: Don't use mmput() from shrinker function.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve Hjonnevag <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>
References: <0000000000001fbbb605aa805c9b@google.com>
 <5ce3ee90-333e-638d-ac8c-cd6d7ab7aa3b@I-love.SAKURA.ne.jp>
 <20200716083506.GA20915@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <36db7016-98d6-2c6b-110b-b2481fd480ac@i-love.sakura.ne.jp>
Date:   Thu, 16 Jul 2020 22:41:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716083506.GA20915@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/16 17:35, Michal Hocko wrote:
> On Thu 16-07-20 08:36:52, Tetsuo Handa wrote:
>> syzbot is reporting that mmput() from shrinker function has a risk of
>> deadlock [1]. Don't start synchronous teardown of mm when called from
>> shrinker function.
> 
> Please add the actual lock dependency to the changelog.
> 
> Anyway is this deadlock real? Mayve I have missed some details but the
> call graph points to these two paths.
> uprobe_mmap					do_shrink_slab	
>   uprobes_mmap_hash #lock
>   install_breakpoint				  binder_shrink_scan
>     set_swbp					    binder_alloc_free_page
>       uprobe_write_opcode			      __mmput
> 	update_ref_ctr				        uprobe_clear_state
>     	  mutex_lock(&delayed_uprobe_lock)	          mutex_lock(&delayed_uprobe_lock);
> 	    allocation -> reclaim
> 

static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm, short d) {
  mutex_lock(&delayed_uprobe_lock);
  ret = delayed_uprobe_add(uprobe, mm1) {
    du = kzalloc(sizeof(*du), GFP_KERNEL) {
      do_shrink_slab() {
        binder_shrink_scan() {
          binder_alloc_free_page() {
            mmget_not_zero(mm2);
            mmput(mm2) {
              __mmput(mm2) {
                uprobe_clear_state(mm2) {
                  mutex_lock(&delayed_uprobe_lock);
                  delayed_uprobe_remove(NULL, mm2);
                  mutex_unlock(&delayed_uprobe_lock);
                }
              }
            }
          }
        }
      }
    }
  }
  mutex_unlock(&delayed_uprobe_lock);
}

> But in order for this to happen the shrinker would have to do the last
> put on the mm. But mm cannot go away from under uprobe_mmap so those two
> paths cannot race with each other.

and mm1 != mm2 is possible, isn't it?

> 
> Unless I am missing something this is a false positive. I do not mind
> using mmput_async from the shrinker as a workaround but the changelog
> should be explicit about the fact.
> 

binder_alloc_free_page() is already using mmput_async() 14 lines later.
It just took 18 months to hit this race for the third time, for it is
quite difficult to let the owner of mm2 to call mmput(mm2) between
binder_alloc_free_page() calls mmget_not_zero(mm2) and mmput(mm2).

The reason I added you is to see whether we can do

 void mmput(struct mm_struct *mm)
 {
 	might_sleep();
+	/* Calling mmput() from shrinker context can deadlock. */
+	WARN_ON(current->flags & PF_MEMALLOC);
 
 	if (atomic_dec_and_test(&mm->mm_users))
 		__mmput(mm);
 }

in order to catch this bug easier.


Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE34C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9853206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgD3OKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:10:18 -0400
Received: from hfcrelay.icp-osb-irony-out7.external.iinet.net.au ([203.59.1.87]:22719
        "EHLO hfcrelay.icp-osb-irony-out7.external.iinet.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgD3OKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:10:13 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BiAABi26pe//onNcoNWRwBAQEBAQE?=
 =?us-ascii?q?HAQESAQEEBAEBQIE2BAEBCwGBfIJMhCGPSgEBBAaBCggligSRVgsBAQEBAQE?=
 =?us-ascii?q?BAQE3BAEBhEQCglQ3Bg4CEAEBAQUBAQEBAQUDAYV3hkkBAQEBAgEjFUEFCws?=
 =?us-ascii?q?YAgImAgJXBgEMBgIBAYMiglgFsnh2gTKFUINngUCBDioBjFp5gQeBOAyCXT6?=
 =?us-ascii?q?HYIJgBJB/h3qZPAiCR5JXBoUkCBudBy2PWJ8dgXkzGggoCIMkUCVXkhxuAQi?=
 =?us-ascii?q?NK2I2AgYIAQEDCZJqAQE?=
X-IPAS-Result: =?us-ascii?q?A2BiAABi26pe//onNcoNWRwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE2BAEBCwGBfIJMhCGPSgEBBAaBCggligSRVgsBAQEBAQEBAQE3BAEBhEQCg?=
 =?us-ascii?q?lQ3Bg4CEAEBAQUBAQEBAQUDAYV3hkkBAQEBAgEjFUEFCwsYAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYMiglgFsnh2gTKFUINngUCBDioBjFp5gQeBOAyCXT6HYIJgBJB/h3qZP?=
 =?us-ascii?q?AiCR5JXBoUkCBudBy2PWJ8dgXkzGggoCIMkUCVXkhxuAQiNK2I2AgYIAQEDC?=
 =?us-ascii?q?ZJqAQE?=
X-IronPort-AV: E=Sophos;i="5.73,336,1583164800"; 
   d="scan'208";a="253537256"
Received: from 202-53-39-250.tpgi.com.au (HELO [192.168.0.106]) ([202.53.39.250])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 30 Apr 2020 22:10:07 +0800
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
Date:   Fri, 1 May 2020 00:10:05 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/4/20 9:03 am, Linus Torvalds wrote:
> On Wed, Apr 29, 2020 at 2:57 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
>>
>> I've never had any reason to use FDPIC, and I don't have any binaries
>> that would use it.  Nicolas Pitre added ARM support, so I guess he
>> would be the one to talk to about it.  (Added Nicolas.)
> 
> While we're at it, is there anybody who knows binfmt_flat?
> 
> It might be Nicolas too.
> 
> binfmt_flat doesn't do core-dumping, but it has some other oddities.
> In particular, I'd like to bring sanity to the installation of the new
> creds, and all the _normal_ binfmt cases do it largely close together
> with setup_new_exec().
> 
> binfmt_flat is doing odd things. It's doing this:
> 
>          /* Flush all traces of the currently running executable */
>          if (id == 0) {
>                  ret = flush_old_exec(bprm);
>                  if (ret)
>                          goto err;
> 
>                  /* OK, This is the point of no return */
>                  set_personality(PER_LINUX_32BIT);
>                  setup_new_exec(bprm);
>          }
> 
> in load_flat_file() - which is also used to loading _libraries_. Where
> it makes no sense at all.

I haven't looked at the shared lib support in there for a long time,
but I thought that "id" is only 0 for the actual final program.
Libraries have a slot or id number associated with them.

> It does the
> 
>          install_exec_creds(bprm);
> 
> in load_flat_binary() (which makes more sense: that is only for actual
> binary loading, no library case).
> 
> I would _like_ for every binfmt loader to do
> 
>          /* Flush all traces of the currently running executable */
>          retval = flush_old_exec(bprm);
>          if (retval)
>                  return retval;
> 
>     .. possibly set up personalities here ..
> 
>          setup_new_exec(bprm);
>          install_exec_creds(bprm);
> 
> all together, and at least merge 'setup_new_exec()' with 'install_exec_creds()'.
> 
> And I think all the binfmt handlers would be ok with that, but the
> flat one in particular is really oddly set up.
> 
> *Particularly* with that flush_old_exec/setup_new_exec() being done by
> the same routine that is also loading libraries (and called from
> 'calc_reloc()' from binary loading too).
> 
> Adding Greg Ungerer for m68knommu. Can somebody sort out why that
> flush_old_exec/setup_new_exec() isn't in load_flat_binary() like
> install_exec_creds() is?
> 
> Most of that file goes back to pre-git days. And most of the commits
> since are not so much about binfmt_flat, as they are about cleanups or
> changes elsewhere where binfmt_flat was just a victim.

I'll have a look at this.

Quick hack test shows moving setup_new_exec(bprm) to be just before
install_exec_creds(bprm) works fine for the static binaries case.
Doing the flush_old_exec(bprm) there too crashed out - I'll need to
dig into that to see why.

Regards
Greg



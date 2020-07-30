Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98605C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796272082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgG3L1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:27:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54301 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgG3L1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:27:31 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06UBRToT022896;
        Thu, 30 Jul 2020 20:27:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Thu, 30 Jul 2020 20:27:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06UBRTGu022886
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 30 Jul 2020 20:27:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] fbmem: pull fbcon_update_vcs() out of fb_set_var()
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
References: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAKMK7uHeteS2+rKrZKrAM+zQO==hAX0XaVc9JfHPsdLTCtzKOw@mail.gmail.com>
 <a3bb6544-064d-54a1-1215-d92188cb4209@i-love.sakura.ne.jp>
 <CAKMK7uGTL02SHbEazu5YEnEncO6c-+P6DXt1GWSVQ28enqLx2g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d4c97785-467a-6e04-b8bb-c8aa4177882a@i-love.sakura.ne.jp>
Date:   Thu, 30 Jul 2020 20:27:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uGTL02SHbEazu5YEnEncO6c-+P6DXt1GWSVQ28enqLx2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/30 20:16, Daniel Vetter wrote:
> Patch looks good, except ... does this compile? fbcon_update_vcs is
> defined in fbcon.h, and that doesn't seem to be included here ...
> Maybe what we want is an fb_set_var_ioctl in fbmem.c so that the fbcon
> interaction is a bit better hidden (but that's a bikeshed, feel free
> to ignore). Also I have no idea what trickery you need to compile-test
> ps3fb, that's why I'm asking :-)

Right. I didn't prepare environment for compiling powerpc kernel.
Kernel test robot found it and I already posted V2 patch as
https://lkml.kernel.org/r/075b7e37-3278-cd7d-31ab-c5073cfa8e92@i-love.sakura.ne.jp .

Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFF1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA2F2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595234402;
	bh=9y8oyfXCi9qMS0EsBRlsVc15TI9TwTZDQvSUwSEyG18=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DPxJxD6COd9dCiWOWCBGX0MYDmzwonIJEDkR5jJemZgyJxYreZttfweBq457CayKt
	 rG/85uVjJSjweGa/YzYIQvLnxCeGUaWNa/ylkyzBHW43zuKdEuwfKCDCjmI99apQhH
	 Od10l09JoKgfNZs/NE3aS96ybwlg6Xjovp03oCNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGTIkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:40:01 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33518 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTIkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:40:00 -0400
Received: by mail-wr1-f51.google.com with SMTP id f18so16989911wrs.0;
        Mon, 20 Jul 2020 01:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zNRmZlw4fbHaNuCudbx8u1IP8YQ+VhQGzyHsJPFQ81E=;
        b=IanS8zfw4kWexwCmhxqxObaKEQDbKbzJkDA6gch80V19iPKXwVXUVdkAox8I6yj7zK
         0tsP2EMzW4br2lsMZDcCcojvqJ4Q98cbEdPIrpCb6Ql4jxhqoLUB0TFDl1fnrK9cgqIq
         Y2NNmSL6hIi5ZnRaQeD5m8lq9NqqS2Me1jam2bs62OJcGAaOCvz3cv4fAo2Vfilf+PPF
         zA/1zSYm5DUeSTWhY9UHi69q2TVMygw4vdZK6ZuSuohqIgzcvRI69FNClEw9lc8jUhna
         vqGOrTPXBbOV+JGNlQ47FQqPINkdTdqEVC2m7huwzmBxRIS9StaCE/wIkhDoXEdiLDmN
         tOnw==
X-Gm-Message-State: AOAM531+ffxD2O/WhNooW+pd43inQqFpzYko9ciRehaMiEqiThRfSUFX
        5mu6sfcIoEh7lKaplpwEEdPhNYmr
X-Google-Smtp-Source: ABdhPJy2pL6Z9cx5U0XTuyBRWAfK0iDuRC8VJndTmXZJlJwq4Phzu72gxXyFGR2rYnCYt3bsfA76xw==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr21737911wrl.246.1595234398703;
        Mon, 20 Jul 2020 01:39:58 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id 129sm31527819wmd.48.2020.07.20.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:39:58 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:39:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: kworker/0:3+pm hogging CPU
Message-ID: <20200720083956.GA4074@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am not sure when this started happening but at least 5.6, 5.7 and
5.8-rc6 all exhibit this problem. Please note that the this is happining
on a laptop which is not completely healthy. The BIOS complains that the
Battery cannot be charged because the power supply cannot be recognized.
This is somehting I have for a longer time without noticing the
kworker/0:3+pm problem so I do not think they are related but who knows.

Anyway, kworker/0:3+pm is hogging CPU. /proc/<pid>/0:3+pm is very often
empty so I suspect it just schedules very often and performs only small
amount of work. Here are few backtraces I've managed to catch

[<0>] preempt_schedule_thunk+0x16/0x18
[<0>] usb_hcd_submit_urb+0x686/0x773
[<0>] usb_start_wait_urb+0x59/0xc8
[<0>] usb_control_msg+0xd4/0x10d
[<0>] get_port_status+0x51/0x6f
[<0>] hub_port_status+0x41/0xa3
[<0>] hub_activate+0x230/0x4ee
[<0>] hub_resume+0x20/0x9a
[<0>] usb_resume_interface.isra.0+0xb0/0xd0
[<0>] usb_suspend_both+0xf6/0x20c
[<0>] usb_runtime_suspend+0x32/0x62
[<0>] __rpm_callback+0x70/0xd4
[<0>] rpm_callback+0x55/0x6b
[<0>] rpm_suspend+0x2af/0x440
[<0>] __pm_runtime_suspend+0x48/0x62
[<0>] usb_runtime_idle+0x26/0x2d
[<0>] __rpm_callback+0x70/0xd4
[<0>] rpm_idle+0x179/0x1df
[<0>] pm_runtime_work+0x6b/0x81
[<0>] process_one_work+0x1bd/0x2c6
[<0>] worker_thread+0x19c/0x240
[<0>] kthread+0x11b/0x123
[<0>] ret_from_fork+0x22/0x30

[<0>] slab_pre_alloc_hook+0x15/0x46
[<0>] __kmalloc+0x148/0x15a
[<0>] usb_hcd_submit_urb+0x5c6/0x773
[<0>] usb_start_wait_urb+0x59/0xc8
[<0>] usb_control_msg+0xd4/0x10d
[<0>] get_port_status+0x51/0x6f
[<0>] hub_port_status+0x41/0xa3
[<0>] hub_activate+0x230/0x4ee
[<0>] hub_resume+0x20/0x9a
[<0>] usb_resume_interface.isra.0+0xb0/0xd0
[<0>] usb_suspend_both+0xf6/0x20c

[<0>] slab_pre_alloc_hook+0x15/0x46
[<0>] __kmalloc+0x148/0x15a
[<0>] usb_hcd_submit_urb+0x5c6/0x773
[<0>] usb_start_wait_urb+0x59/0xc8
[<0>] usb_control_msg+0xd4/0x10d
[<0>] set_port_feature+0x33/0x38
[<0>] hub_suspend+0x15c/0x16a
[<0>] usb_suspend_both+0x91/0x20c
[<0>] usb_runtime_suspend+0x32/0x62
[<0>] __rpm_callback+0x70/0xd4
[<0>] rpm_callback+0x55/0x6b
[<0>] rpm_suspend+0x2af/0x440
[<0>] __pm_runtime_suspend+0x48/0x62
[<0>] usb_runtime_idle+0x26/0x2d
[<0>] __rpm_callback+0x70/0xd4
[<0>] rpm_idle+0x179/0x1df
[<0>] pm_runtime_work+0x6b/0x81
[<0>] process_one_work+0x1bd/0x2c6
[<0>] worker_thread+0x19c/0x240
[<0>] kthread+0x11b/0x123
[<0>] ret_from_fork+0x22/0x30

Is this something known or something I can give more information about?
From a very quick look into the code it sounds as if the system wanted
to suspend an USB device/controller but that keeps failing again and
again.
-- 
Michal Hocko
SUSE Labs

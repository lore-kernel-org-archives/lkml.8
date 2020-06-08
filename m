Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D084220656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgFHIGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:06:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbgFHIGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:06:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE344B01D;
        Mon,  8 Jun 2020 08:06:32 +0000 (UTC)
Date:   Mon, 8 Jun 2020 10:06:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: dump kmessage before machine_kexec
Message-ID: <20200608080627.GD5099@linux-b0ei>
References: <20200605194642.62278-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605194642.62278-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-06-05 15:46:42, Pavel Tatashin wrote:
> kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
> machine_restart(), machine_halt(), machine_power_off(), the only one that
> is missing is  machine_kexec().
> 
> The dmesg output that it contains can be used to study the shutdown
> performance of both kernel and systemd during kexec reboot.
> 
> Here is example of dmesg data collected after kexec:
> 
> root@dplat-cp22:~# cat /sys/fs/pstore/dmesg-ramoops-0 | tail
> ...
> <6>[   70.914592] psci: CPU3 killed (polled 0 ms)
> <5>[   70.915705] CPU4: shutdown
> <6>[   70.916643] psci: CPU4 killed (polled 4 ms)
> <5>[   70.917715] CPU5: shutdown
> <6>[   70.918725] psci: CPU5 killed (polled 0 ms)
> <5>[   70.919704] CPU6: shutdown
> <6>[   70.920726] psci: CPU6 killed (polled 4 ms)
> <5>[   70.921642] CPU7: shutdown
> <6>[   70.922650] psci: CPU7 killed (polled 0 ms)
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FADAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8DB20812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591692643;
	bh=inVJL1pBaM/2Esv94VoALP7DgQZqZS9LcZ/dSphQwsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IhMj4n+OMshf6ntCgQi+4p6kAgAiTj7P/6Q7qf+lL4l7HENpolw9cdJQMlU/OEF6d
	 Nc5jw9at7BwJE0JWx6h075VQPxX/wuFyNqpnv5aXdbmFnM4AKZP/X11xbxgRsvtZdB
	 +qBU9oc22FtrGIqmG5pl1sC/dRsv7/MZDOjFBFiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgFIIul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgFIIul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:50:41 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47EDE2078D;
        Tue,  9 Jun 2020 08:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591692640;
        bh=inVJL1pBaM/2Esv94VoALP7DgQZqZS9LcZ/dSphQwsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MckQA8WeqpKxgslfsAJpE+5q26uVvey34xcJIEN6I6kNKDjBEC2jugP5enTLmL1Mg
         kf6LYIJFUIpp+DLm3ZuvAyRA0rl4i9tZjcJN2FB3HnL0dMtdsEUWppJAOt69T1ax8C
         /0eCUsnQdKMrMDglmuKP2gEkUmRbB/RyMGmSRri4=
Received: by pali.im (Postfix)
        id 6C6D8884; Tue,  9 Jun 2020 10:50:38 +0200 (CEST)
Date:   Tue, 9 Jun 2020 10:50:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     y.linux@paritcher.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH v2 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Message-ID: <20200609085038.vte777tltyeojjxs@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <74fdb288757cf5970a558f920f531b3bd1c51b47.1591656154.git.y.linux@paritcher.com>
 <20200608233303.57ubv4rxo4tnaaxa@pali>
 <295ad85ecc464a57bffd5b783d4170a1@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295ad85ecc464a57bffd5b783d4170a1@AUSX13MPC105.AMER.DELL.COM>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 June 2020 00:26:45 Mario.Limonciello@dell.com wrote:
> > Mario, are you able to get some official documentation for these 0x0012
> > event types? I think it could be really useful for community so they can
> > understand and add easily new type of code and events. Because currently
> > we are just guessing what it could be. (It is sequence? Or single event?
> > Or single event with extended data? It is generic event? Or it is real
> > keypress? etc...)
> 
> It's a single event with more data in the subsequent words.  It is definitely
> not a real keypress.  It's supposed to be data that a user application would show.
> 
> Remember the way WMI works on Linux and Windows is different.  On Windows
> userland applications get the events directly.  On Linux kernel drivers get the
> events and either use it internally, pass to another kernel driver or pass to
> userland in the form of a translated event.
> 
> So on Windows the whole buffer gets looked at directly by the application and the
> application will decode it to show a translated string.
> 
> I can certainly discuss internally about our team releasing a patch to export
> all these other events.  I would like to know what interface to recommend it pass
> to userspace though, because as I said this is more than just a keycode that
> comes through in the event.  It's not useful to just do dev_info, it really should
> be something that userspace can act on and show a translated message.
> I don't think we want to add another 15 Dell specific keycodes to the kernel for the
> various events and add another 4 more when a laptop introduces another set of keys.

Which interface to use for events? That is a good question and probably
this should be bring to the linux-input mailinglist. I think that
linux-input maintainers could have idea how to do it properly. We need
some interface which would be general enough and usable also by other
drivers / components and I'm sure that ACPI/WMI is not the only
subsystem which needs to send events from kernel to userspace.

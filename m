Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D78A208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgATL6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:58:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:46845 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgATL6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:58:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 03:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,341,1574150400"; 
   d="scan'208";a="275091434"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 20 Jan 2020 03:58:29 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Jan 2020 13:58:28 +0200
Date:   Mon, 20 Jan 2020 13:58:28 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Markus Reichl <m.reichl@fivetechno.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: [Bug ?] usb :typec :tcpm :fusb302
Message-ID: <20200120115828.GC32175@kuha.fi.intel.com>
References: <0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Thu, Jan 09, 2020 at 05:29:07PM +0100, Markus Reichl wrote:
> Hi,
> 
> I'm working with a ROC-RK3399-PC arm64 board from firefly, circuit sheet [1].
> The board is powered from an USB-C type connector via an FUSB302 PD controller.
> With measured 15W+ power consumption it should use higher voltage PD modes than
> the standard 5V USB-C mode.
> 
> When I add the related connector node in DTS [2] the FUSB302 initializes
> the right PD mode (e.g. 15V/3A).
> 
> But during initialisation the PD is switched off shortly and the board has a blackout.
> When I inject a backup supply voltage behind the FUSB302 (e.g. at SYS_12V line) during boot
> I can remove the backup after succesfull setting up the PD and the board will run fine.
> 
> Is it possible to change the behaviour of the fusb302 driver to not power down the PD supply
> during init?

I guess it's also possible that the problem is with tcpm.c instead of
fusb302.c. tcpm.c provides the USB PD state matchines. Guenter! Can
you take a look at this?

Both tcpm.c and fusb302.c create debugfs entries that have a more
detailed log about things that are happening. Can you check what you
have in those (when you boot with the mains cable plugged it)?

        % mount debugfs -t debugfs /sys/kernel/debug
        % cat /sys/kernel/debug/tcpm*
        % cat /sys/kernel/debug/fusb302/*

Which kernel are you running by the way?

> In vendor kernel (4.4) this is done somehow but the sources are too different for me to find
> out how.
> 
> Gruß,
> -- 
> Markus Reichl
> 
> [1]
> http://download.t-firefly.com/product/RK3399/Docs/Hardware/%E5%8E%9F%E7%90%86%E5%9B%BE%E5%92%8C%E8%B4%B4%E7%89%87%E5%9B%BE/ROC-RK3399-PC/ROC-3399-PC-V10-A-20180804_%E5%8E%9F%E7%90%86%E5%9B%BE.pdf
> 
> [2]
> https://lkml.org/lkml/2019/12/10/517

-- 
heikki

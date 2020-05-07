Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0644DC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC742080D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588833949;
	bh=gm75SLJLcH+JMNI3GZMkQmuSFwAf5JbNY0WtEMPJqUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P/Pqn3ul5C4QRXVbXbXYP2DuT4jcLXzf7cK+pB6ps7hZUEgZ0MC+f7cQXtWotR2I+
	 OYH6thLEhMcNWQHmoCsGRkKI97csTq0q313coTCpbDQNAA/K0DLDFXYUrh9JMyQq+x
	 EB+Jfpmw6OXLbt0kEcQBtmHn3hWxLLuHJSANJIc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgEGGps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgEGGps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:45:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951262078C;
        Thu,  7 May 2020 06:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588833948;
        bh=gm75SLJLcH+JMNI3GZMkQmuSFwAf5JbNY0WtEMPJqUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wGxD1c5COzsllDgnff5fUZ8KoK3yIZEqdaBc/68jMU7MQ/3AKuqnNp/9aiy6avTnz
         ncAnmKDGHXjVkeUjq7l6TiVZnQ/pcwenIdSH2vV50XzXppzWQ5SgO4eZPpUtJCNdI+
         wrZt4neRbzHokNBrxQy+oB0poCslOEPNme2B527A=
Date:   Thu, 7 May 2020 08:45:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/1] usb: chipidea: msm: Ensure proper controller reset
 using role switch API
Message-ID: <20200507064545.GB787064@kroah.com>
References: <20200507004918.25975-1-peter.chen@kernel.org>
 <20200507004918.25975-2-peter.chen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507004918.25975-2-peter.chen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 08:49:18AM +0800, Peter Chen wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Currently we check to make sure there is no error state on the extcon
> handle for VBUS when writing to the HS_PHY_GENCONFIG_2 register. When using
> the USB role-switch API we still need to write to this register absent an
> extcon handle.
> 
> This patch makes the appropriate update to ensure the write happens if
> role-switching is true.
> 
> Fixes: 05559f10ed79 ("usb: chipidea: add role switch class support")
> 
> Cc: Peter Chen <Peter.Chen@nxp.com>

No blank line needed, and you can drop your own Cc: in the patch :)

I'll edit it by hand...

greg k-h

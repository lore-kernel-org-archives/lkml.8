Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA51C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337D1206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584322553;
	bh=Pe21SKQQImoQ+N5g/3EBwXNef2SZeK2GRe1NDH9iSVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J1quLI7lSW6fbitkXDT/9BUMmPN4yoPiZc64pXkK1s0SaiWJNlsx9SWmPmmzQKZoy
	 SqjSuGaIpOOyqIdE1peq78S4ZEhbGzRwhbyG7r4uzhz8uRo9Qbcgdx2cDeWXRIDKKR
	 e8OJit6Ye8c1KLR7dRykAWnY7wQmAwheKgE5Z8Vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgCPBfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgCPBfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:35:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A44020663;
        Mon, 16 Mar 2020 01:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584322551;
        bh=Pe21SKQQImoQ+N5g/3EBwXNef2SZeK2GRe1NDH9iSVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zFX654fz0Nz/DcMuQiotV+MnxCLgGdT34wd4BBgzcKWjWa/NyTJmTWZ2kzBOfzgnd
         /bI0AlFlw3yIhDyoeQNuz4eHlCokrZNoYOQHFRZUtb1K9Fh7ObQSkbPahFJW7AST7W
         jKDz8ZR4Qw0heqBYdhIpEXFYPqvQmDXJ7f8jdwsQ=
Date:   Mon, 16 Mar 2020 09:35:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8qxp-mek: Sort labels
 alphabetically
Message-ID: <20200316013541.GR17221@dragon>
References: <1584321993-8642-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584321993-8642-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 09:26:32AM +0800, Anson Huang wrote:
> Sort the labels alphabetically for consistency.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.

Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC53C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9277020771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592895652;
	bh=NwzkhvLTdaiMVPiInrrB1GVy05m9nUU2QlCfp66VRNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GzrayrDuUYzBa/qGnEINryObbhA63NQCeQzm20wbbGcOfgyzpxy11CPofrnQ681MJ
	 gv0QL6rdImQQAhlxrLhi5mC+9eKo+F+M7sbRAx6JfUjcLv8JYvpWB+cFLb+cae3mRg
	 IUu7np9I4CxKaf6KeNxVj4YB2XoAhd/t8oUvUrS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbgFWHAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbgFWHAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:00:50 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647D520724;
        Tue, 23 Jun 2020 07:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895650;
        bh=NwzkhvLTdaiMVPiInrrB1GVy05m9nUU2QlCfp66VRNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NaWIjmO44k0EzJmLo1BWA/+CqFZ1ov5yHwrdFmo6dLZgKf1X/rw1rmxoja8CZQ/5i
         yHCza3p7c5yKWVi4ZecZQeCj9WWBvYn135gqhmiP9rqSwCZ7lLFuajdWg0gHxvKwlb
         Q/m6NU66dDmnsHJDsfi8gQGq69IkZLA1QpGIEYp4=
Date:   Tue, 23 Jun 2020 15:00:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] ARM: dts: imx: Change sdhci node name on
 i.MX27/i.MX31 SoCs
Message-ID: <20200623070039.GS30139@dragon>
References: <1591079092-18625-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591079092-18625-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:24:50PM +0800, Anson Huang wrote:
> Change i.MX27/i.MX31 node name from sdhci to mmc to be compliant
> with yaml schema, it requires the nodename to be "mmc".
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.

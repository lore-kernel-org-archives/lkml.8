Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB28C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5698D20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584323135;
	bh=tzHkYQUduhfzNU7kQbblTYrs2p7fAYSfY48bdXcW9T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qMpq5DmMTri7rR+m4VkVPDRucdAeWhJUa51NPEoLMViF4V0P2OEbnGSLf1PQVvs5S
	 MRh98LCJ/FV0Dnu+sdliVj1SsIxzJTD5T15ZAkjDUwiaVVUeLayRoVlQVY8H45rCJT
	 iSEUM5+UoFtoZrtOE36H+agbj6WadoKa/n4bBsjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgCPBpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbgCPBpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:45:34 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06AB42051A;
        Mon, 16 Mar 2020 01:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584323133;
        bh=tzHkYQUduhfzNU7kQbblTYrs2p7fAYSfY48bdXcW9T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/JrR3krA9rtF2c1tDFQKGX1CKpEZMHNe0CY54/MhV+rRtonplL/qaxyXZ2TKBjYi
         SJRhGj8qtf0CuStBqwFpB1KPH3l3rfvwVCL+G1UQjTbxA/Gr7oMrbvdFwsKIPend8u
         H1yDgtt35G52pl550vvhvSabNXNqXWkvw7cP2iU4=
Date:   Mon, 16 Mar 2020 09:45:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, horia.geanta@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Add snvs clock to powerkey
Message-ID: <20200316014526.GU17221@dragon>
References: <1583998450-19292-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583998450-19292-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 03:34:09PM +0800, Anson Huang wrote:
> SNVS powerkey driver needs snvs clock for proper clock management,
> add support for it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.

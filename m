Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D23820786
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592881308;
	bh=vDOuS8RpaAzFZqbGkD5xxV2WoIOlKdteQNq9eaFY3Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wYysfnKbUvuSgHzZQ5WRkblPXblXF2TZZ95pABHu3Exo76Gm39Nq/iS1XyNjqlzr9
	 wQ1/6vxTP/zX0hITCOVUM8Wb8qaZCCNuR1jWXEAiQkW+q2oUSaz3NDbIcxUYt5UVhO
	 8MiHEleBa5hmsBl9MwS4S8KNv+cLq54FsEMUyq9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbgFWDBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 23:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731788AbgFWDBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:01:47 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA19F2076A;
        Tue, 23 Jun 2020 03:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592881306;
        bh=vDOuS8RpaAzFZqbGkD5xxV2WoIOlKdteQNq9eaFY3Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GeWCzUjgozzXMZGgptbtH8rlZG7589ImrXs+2uWhSXaIRH0bhufH9EENP3uMd+6iD
         GiHtWejo6R1POtlEe8yhjw5K4Ra2AVDUkDRI6h87fZXfv+T3tB33uIdBpP51j86fkv
         LYesaH7dN24jm+VBqOZdyx3IMp7qaQMY1JkWcBZQ=
Date:   Tue, 23 Jun 2020 11:01:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com,
        peng.fan@nxp.com, aford173@gmail.com, jun.li@nxp.com,
        shengjiu.wang@nxp.com, horia.geanta@nxp.com, aisheng.dong@nxp.com,
        fugang.duan@nxp.com, agx@sigxcpu.org, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 0/4] Change i.MX/MXS SoCs ocotp/iim node name to efuse
Message-ID: <20200623030130.GH30139@dragon>
References: <1590635570-8541-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590635570-8541-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:12:46AM +0800, Anson Huang wrote:
> In the nvmem yaml schema, it requires the nodename to be one of
> "eeprom|efuse|nvram", so need to change all i.MX/MXS SoCs ocotp/iim node
> name to efuse:
> 
> MXS platforms: i.MX23/28;
> i.MX platforms with IIM: i.MX25/27/31/35/51/53.
> i.MX ARMv7 platforms with OCOTP: i.MX6QDL/6SL/6SX/6SLL/6UL/7S/7ULP.
> i.MX ARMv8 platforms with OCOTP: i.MX8MQ/8MM/8MN/8MP.
> 
> Anson Huang (4):
>   ARM: dts: imx: change ocotp node name on i.MX6/7 SoCs
>   arm64: dts: imx8m: change ocotp node name on i.MX8M SoCs
>   ARM: dts: imx: change ocotp node name on MXS SoCs
>   ARM: dts: imx: change iim node name on i.MX SoCs

Applied all, thanks.

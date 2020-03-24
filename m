Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E8FC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE0420658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="N7KpoxrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCXMOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:14:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42108 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCXMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:14:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so8909477wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9cH/I+t9PFd3u2vbahwfiKP9qNEMIBaetJ3OV+SCdAE=;
        b=N7KpoxrPz6E2B6wkVEQ8p7AzGW2dwOWElV7hmrCHCcUYwM6ghb4/uWMEO19/YbkS9v
         HbbnROsj57t+b7XNEhv0jG0oh4RiYpwkms+atnHpSKwVk4fr+CtlCHKr0dr5rctRT/FC
         z3ZNF55T1ggoQZVFkWDhJJ52gysV9yPhnc7ZfHsM9tLtskJ9yXSxy4kBfsmRQJpowdY3
         Dmr+VLCe15KUnBfD4VlsNCFlcR/ads2IehfQOVYgL8J5HcHIRBdDo9NfHaRZ5um4PYhM
         kXKJVY7CwdXaWYUfgi/TzCKc7YW3JS88YrMr/ACtc3cNQsbISJOCneShks/8w3JzPh7X
         efKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9cH/I+t9PFd3u2vbahwfiKP9qNEMIBaetJ3OV+SCdAE=;
        b=amdD++AmDS+GOJyimnGNGy54zKNdltPyo7AjnoFJcO6/QaAaqziQSJyK4+Mkt8ujJ0
         DAs2jinpbVlKLFZfzRAQSpKq7ncKb3kAsXQFo2pTW2i3aj0utyn5vLT6xpbaNxsYwa9p
         lSV+jyQgX9BTwWHsouVfKbpzkznJdtO3bpdLgqjSnJCaNeFm9OXfhsfc1tNohPFSBoxu
         tXR6TQvk4bgjvg493xb3ILyJUT2GpGGSdT9vACnYc/J3Dkh3Y86NGhFsP1jylAW2I7gR
         fyIAAIl5ZRtYLULc/EuXUyKqZUMPO1012uB24C9mL66rAiU1swaY2tNnHrqyTTCjVPTT
         no0g==
X-Gm-Message-State: ANhLgQ3JXFI/Z96oBvH99e9+IfVXvjvLb7Wowc3BXIZ0tbyqfuEqajen
        Je5XjyNsQMXOAoKfL8o+OPBqcg==
X-Google-Smtp-Source: ADFU+vszswxXGxDV0gh3cD3DJLBtCQsNeMc4YTtzIkebuK6qtx+9BV4UMVSVInSWXvKzAiQ9JyO1bg==
X-Received: by 2002:a5d:6581:: with SMTP id q1mr20647675wru.17.1585052070328;
        Tue, 24 Mar 2020 05:14:30 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id k15sm5741157wrm.55.2020.03.24.05.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 05:14:29 -0700 (PDT)
Date:   Tue, 24 Mar 2020 13:14:28 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Po Liu <Po.Liu@nxp.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, vinicius.gomes@intel.com,
        claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
        alexandru.marginean@nxp.com, xiaoliang.yang_1@nxp.com,
        roy.zang@nxp.com, mingkai.hu@nxp.com, jerry.huang@nxp.com,
        leoyang.li@nxp.com, michael.chan@broadcom.com, vishal@chelsio.com,
        saeedm@mellanox.com, leon@kernel.org, jiri@mellanox.com,
        idosch@mellanox.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, kuba@kernel.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, simon.horman@netronome.com,
        pablo@netfilter.org, moshe@mellanox.com, m-karicheri2@ti.com,
        andre.guedes@linux.intel.com, stephen@networkplumber.org
Subject: Re: [v1,net-next  4/5] net: enetc: add hw tc hw offload features for
 PSPF capability
Message-ID: <20200324121428.GT11304@nanopsycho.orion>
References: <20200306125608.11717-11-Po.Liu@nxp.com>
 <20200324034745.30979-1-Po.Liu@nxp.com>
 <20200324034745.30979-5-Po.Liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324034745.30979-5-Po.Liu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Mar 24, 2020 at 04:47:42AM CET, Po.Liu@nxp.com wrote:

[...]


>@@ -289,9 +300,53 @@ int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
> void enetc_sched_speed_set(struct net_device *ndev);
> int enetc_setup_tc_cbs(struct net_device *ndev, void *type_data);
> int enetc_setup_tc_txtime(struct net_device *ndev, void *type_data);
>+
>+static inline void enetc_get_max_cap(struct enetc_ndev_priv *priv)
>+{
>+	u32 reg = 0;

Pointless init.


>+
>+	reg = enetc_port_rd(&priv->si->hw, ENETC_PSIDCAPR);
>+	priv->psfp_cap.max_streamid = reg & ENETC_PSIDCAPR_MSK;
>+	/* Port stream filter capability */
>+	reg = enetc_port_rd(&priv->si->hw, ENETC_PSFCAPR);
>+	priv->psfp_cap.max_psfp_filter = reg & ENETC_PSFCAPR_MSK;
>+	/* Port stream gate capability */
>+	reg = enetc_port_rd(&priv->si->hw, ENETC_PSGCAPR);
>+	priv->psfp_cap.max_psfp_gate = (reg & ENETC_PSGCAPR_SGIT_MSK);
>+	priv->psfp_cap.max_psfp_gatelist = (reg & ENETC_PSGCAPR_GCL_MSK) >> 16;
>+	/* Port flow meter capability */
>+	reg = enetc_port_rd(&priv->si->hw, ENETC_PFMCAPR);
>+	priv->psfp_cap.max_psfp_meter = reg & ENETC_PFMCAPR_MSK;
>+}
>+
>+static inline void enetc_psfp_enable(struct enetc_hw *hw)
>+{
>+	enetc_wr(hw, ENETC_PPSFPMR, enetc_rd(hw, ENETC_PPSFPMR)
>+		 | ENETC_PPSFPMR_PSFPEN | ENETC_PPSFPMR_VS

Hmm, I think it is better to have "|" at the end of the line".


>+		 | ENETC_PPSFPMR_PVC | ENETC_PPSFPMR_PVZC);
>+}
>+
>+static inline void enetc_psfp_disable(struct enetc_hw *hw)
>+{
>+	enetc_wr(hw, ENETC_PPSFPMR, enetc_rd(hw, ENETC_PPSFPMR)
>+		 & ~ENETC_PPSFPMR_PSFPEN & ~ENETC_PPSFPMR_VS

Same here.


>+		 & ~ENETC_PPSFPMR_PVC & ~ENETC_PPSFPMR_PVZC);
>+}
> #else
> #define enetc_setup_tc_taprio(ndev, type_data) -EOPNOTSUPP
> #define enetc_sched_speed_set(ndev) (void)0
> #define enetc_setup_tc_cbs(ndev, type_data) -EOPNOTSUPP
> #define enetc_setup_tc_txtime(ndev, type_data) -EOPNOTSUPP

[...]

Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8E0C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51D220842
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="QDAlHA9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCXKBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:01:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46877 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgCXKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:01:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so17208211wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXwXXyf4FFoH6g7bKxTH+XMwT8dvCco8fnyGy8BbH0U=;
        b=QDAlHA9bG8dxJapJMUVdl7SSfzjRwftlM0jT/kCptr/tZzU0kY2soxUAM3ezP1rj/K
         NLWi5HDGR2pSC0+mTbUvx3FNzvBl6v4EJo03KBnlB1svpO4emsIa8635EHUgU9/1iOGe
         Po5VJK/wDQ/keZp1zbUujB4U5LdA/uzELiJlako/i0PxNdyYZU7HFbGz/7woBdChgpWh
         wKHuLwTYxPKxdy76wZie4l6JXj1pfcUCW1iXMfAhrl/kNTsXubyLICwVmXHTouEsreeJ
         sVYV5p6rX6yW2GfD+w+zg7pwq8J3EqXT2rRKwfkk8HORngkZ8bW6OVP8FXTLoUHE2wLF
         X8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXwXXyf4FFoH6g7bKxTH+XMwT8dvCco8fnyGy8BbH0U=;
        b=ltVl3LtexHW9aODodAWTJ14H0ztfSqxScmRFCW3QRZL0s7yM3PR3OS3rhTchdYHNRL
         DJwjmY002aRuD0Lt5YK71UBGBZLI7oeCb23zmJNZRDCKxUW84UklLi3fffFE4VkhiW4q
         VXec04ZvuhmOT34YvEkDDD2ZzagmCYKH3mwuS6LVr5zmTV6LuISzRg0pUA2DybuZAjty
         lS6PHKtdy3pkAuVthJqL2agVoig/6nmst7cMPItb5BD5SDle+y0KOxGQLXDI0AwDsdVQ
         we/Pi8wD3XZjAnWgcaMhqLamVdUwId6w3U8HGVqrkhx1dIakFxFCWIOi5nCaeSvdtdCw
         WJKA==
X-Gm-Message-State: ANhLgQ0TqT3pNgYIHz4kNfELU2l/IfJIQalrJ8UvobO9gyV+vzJsRlKZ
        XbijV/so8kiQe1zJBE03Uk+g6Q==
X-Google-Smtp-Source: ADFU+vs+oZMrTA+XjIVihEjmm3kkuM0VpBBT6FouF1t7AnwQf9AWhrAkOA5fgdwclkEuWXDSzOly8A==
X-Received: by 2002:adf:9dc6:: with SMTP id q6mr34986704wre.70.1585044109070;
        Tue, 24 Mar 2020 03:01:49 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id t81sm3607126wmb.15.2020.03.24.03.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:01:47 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:01:46 +0100
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
Subject: Re: [v1,net-next  1/5] net: qos offload add flow status with dropped
 count
Message-ID: <20200324100146.GR11304@nanopsycho.orion>
References: <20200306125608.11717-11-Po.Liu@nxp.com>
 <20200324034745.30979-1-Po.Liu@nxp.com>
 <20200324034745.30979-2-Po.Liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324034745.30979-2-Po.Liu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Mar 24, 2020 at 04:47:39AM CET, Po.Liu@nxp.com wrote:
>Add the hardware tc flower offloading with dropped frame counter for
>status update. action ops->stats_update only loaded by the
>tcf_exts_stats_update() and tcf_exts_stats_update() only loaded by
>matchall and tc flower hardware filter. But the stats_update only set
>the dropped count as default false in the ops->stats_update. This
>patch add the dropped counter to action stats update. Its dropped counter
>update by the hardware offloading driver.
>This is changed by replacing the drop flag with dropped frame counter.

I just read this paragraph 3 times, I'm unable to decypher :(



>
>Driver side should update how many "packets" it filtered and how many
>"dropped" in those "packets".
>

[...]


> 	return action;
> }
> 
>-static void tcf_gact_stats_update(struct tc_action *a, u64 bytes, u32 packets,
>-				  u64 lastuse, bool hw)
>+static void tcf_gact_stats_update(struct tc_action *a, u64 bytes, u64 packets,
>+				  u64 lastuse, u64 dropped, bool hw)
> {
> 	struct tcf_gact *gact = to_gact(a);
> 	int action = READ_ONCE(gact->tcf_action);
> 	struct tcf_t *tm = &gact->tcf_tm;
> 
>-	tcf_action_update_stats(a, bytes, packets, action == TC_ACT_SHOT, hw);
>+	tcf_action_update_stats(a, bytes, packets,
>+				(action == TC_ACT_SHOT) ? packets : 0, hw);

Avoid ()s here.


> 	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
> }
> 

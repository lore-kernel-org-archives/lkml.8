Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B403C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5967E20853
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJQ40VwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgFQVkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFQVkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:40:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71C7C06174E;
        Wed, 17 Jun 2020 14:40:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p5so3914186wrw.9;
        Wed, 17 Jun 2020 14:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tdxAnfgHfsRu25mT+OxtZg51u9F1VhBEhhhiBFNKCsk=;
        b=RJQ40VwTsQGrYwjKSxrMtXd3nJLKxujv+qp3fj9x9EqU1Yfc/TMcA3NS6KB+AWMdoJ
         yuaobs7Po8gIpaqFe5yPuzYmBMgwwvKwKaWNkN1g9IIBWu69fVOJh4crFteBZWqNzUKy
         YUqsNqW1L69Ep72+D7Gk9sC2szR8rRSxXprkr6xzzjI7gYdrJzpj7U0kTrZhXoWC0M95
         oYkF3xsd49gsTmw142pF8+lAhzoqP42YZ80dwD7yB7UWNLHo1aIE6naHTyAB7OogfXgl
         WFJjz/UPfUMzE9ASgR4d3GrjGkAhQyxV2Z2mTwo3Ip0thsE7N1mSwMtPp0S/xLdGuXB/
         GXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tdxAnfgHfsRu25mT+OxtZg51u9F1VhBEhhhiBFNKCsk=;
        b=tH9r+xtlwxMnmtJfeSOFDtI2m5A6xvJrm+XZZoivwMsBix5vxklxHYl77o1Dv1rZhV
         UeRAGcwUFNRHkrecQ424OUC5oHJxiveyRMppFhyuwzkRU42YMEkWQRx2ijIv4UjzoXAa
         XfuY98q/pDPNJPAujzNHBF8b1EZsK/BQN8dA6wKKG8nqlbAHz3v7f2kN4TluRsKP8Kd/
         E6anV5sNHCOqWXmdxq84ARG2bjKCmmd3nA4Y5FnhHIfvMPORs+S636oN0o7cQNbYTiNF
         g0KWo0Gxw1E9H3OT8AqMoEZ+vMn1eU3sj2XeFybCaLAfJXNW0wn1dGyyMPWv6l3BDmYl
         SxYg==
X-Gm-Message-State: AOAM532wm3R8bM9a5W6NlxZC+OIHwQ/kJwgTU3t/ytlMsg5bv+7N4oTT
        uO/MNISI5Ozpem+HP1b2+QHBxH81
X-Google-Smtp-Source: ABdhPJzHdexF9zhmK8KE6PQXWc21U/TZcL6JBgmmEvG9RPxaIknHPV9quDQmTaTTVSDjxAm4Azza5A==
X-Received: by 2002:a5d:4d89:: with SMTP id b9mr1328829wru.210.1592430020210;
        Wed, 17 Jun 2020 14:40:20 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id f11sm981816wrj.2.2020.06.17.14.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:40:19 -0700 (PDT)
Subject: Re: [PATCH 6/8] mips: bmips: add BCM6368 clock definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20200615090231.2932696-1-noltari@gmail.com>
 <20200615090231.2932696-7-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2fb17140-fb61-ffaa-91cd-e32449e3ef08@gmail.com>
Date:   Wed, 17 Jun 2020 14:40:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090231.2932696-7-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 2:02 AM, Álvaro Fernández Rojas wrote:
> Add header with BCM6368 definitions in order to be able to include it from
> device tree files.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

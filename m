Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B4AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573E1207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1WuP0/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgG3A7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgG3A7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:59:09 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43700C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 17:59:09 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id a19so5787251qvy.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 17:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvrLbBz23Qi9qZt+PlDSWFrxdJtaH3KDvcxiTll5gPg=;
        b=a1WuP0/z8YBXQm8dAGSVlGXhnzVqgJRZZx9/CeUWuJcvd9c2nUMsSgDpNA+XH4bTzE
         k1MYIGoBBPbLkSeQ3em1oMnm8PLRb32pYPA6qJ5X+jYYZOfu4axM3s5/x0YMduFz6Mv2
         GTxFK9k2ZCaFN+DQ33oUz8hWNWpGwZWsE5uGYYv3+hD/9IRUnj9W5aOg23rQSkfDupqm
         9C6yLrShSlPmIO7qR35N15Q06QkUKuaUY9LW/zGaT7DzVmB0jPrN8w/4/mSwQpDNzKrf
         pcZwC+p/IqHbB2HaxagoW2QItY/gFxBJ4kysedwNODEggJphwDgHA/aZJOOH63Flc4oh
         7h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvrLbBz23Qi9qZt+PlDSWFrxdJtaH3KDvcxiTll5gPg=;
        b=ny2DLHV8hTUCRVOMyT1S0cINRc2bobTeZ2fxlu4vCOUElkft0BSi2evzzeRZYr6s/q
         ywbtozISeoNv5JOmWUwimVVrS+8f+HvS08AyDLXwx0kj6KRqWqI37dUp1zozX3VSt3KX
         1xPPCUcux9FKWsLK2WJzlXmlRLRilv4Hr1Nn7Sy9xPn3XhXzosD6sGmWinQGrZGSbbtN
         SKppcxVZCWN7rxxvev+K2yi4pyB8SQueAc/VpRH/swcjgm307/XFLNoTTcXYiLKOdYkL
         Bg4RLImh5B6b9V/yoJrVsOzbVgqefWH8J236LrCr15YDorI7ywirvF196NClhSzP99lm
         mxnA==
X-Gm-Message-State: AOAM533ic0WwAgZsjfewY2Uwm2uHDipJXkFoIBGM0cJ9p38Lpv/Q75jf
        c92lrVNgASQct3BMqHwxJn/DbxgIMjE=
X-Google-Smtp-Source: ABdhPJyULtb3tT37oV4dIBUvs6SmvhGlv2A9Vx14/liwzBjg/Ku8iSth2/tYN3xQR89Oim54dKLbfg==
X-Received: by 2002:a0c:a81a:: with SMTP id w26mr552226qva.52.1596070748226;
        Wed, 29 Jul 2020 17:59:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:1a1:217b:9469:41a3:f900:755c])
        by smtp.gmail.com with ESMTPSA id s30sm3183612qtc.87.2020.07.29.17.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 17:59:07 -0700 (PDT)
From:   Rodrigo Madera <rodrigo.madera@gmail.com>
X-Google-Original-From: Rodrigo Madera <madera@acm.org>
To:     hch@lst.de
Cc:     christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: bpfilter logging write errors in dmesg
Date:   Wed, 29 Jul 2020 21:59:02 -0300
Message-Id: <20200730005902.236086-1-madera@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727145013.GA2154@lst.de>
References: <20200727145013.GA2154@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

I see the same issue on my AMD 3990x using v5.8rc7:

[   10.229424] bpfilter: Loaded bpfilter_umh pid 1906
[   10.229467] Started bpfilter
[   10.229538] pos invalid: -131326014643272
[   10.229539] bpfilter: write fail -22
[   10.229603] pos invalid: -2127991714
[   10.229604] bpfilter: write fail -22
[   10.232222] bpfilter: Loaded bpfilter_umh pid 1908
[   10.232292] Started bpfilter
[   10.232355] pos invalid: -131322530713744
[   10.232357] bpfilter: write fail -22
[   10.232389] pos invalid: -2127991714
[   10.232390] bpfilter: write fail -22
[   10.233986] bpfilter: Loaded bpfilter_umh pid 1911
[   10.234056] Started bpfilter
[   10.234898] pos invalid: -2127991714
[   10.234900] bpfilter: write fail -22
[   10.234907] pos invalid: -2127991714
[   10.234908] bpfilter: write fail -22
[   10.235797] bpfilter: Loaded bpfilter_umh pid 1914
[   10.235871] Started bpfilter
[   10.235928] pos invalid: -2127991714
[   10.235929] bpfilter: write fail -22
[   10.235936] pos invalid: -2127991714
[   10.235936] bpfilter: write fail -22
[   10.236834] bpfilter: Loaded bpfilter_umh pid 1916
[   10.236897] Started bpfilter
[   10.236955] pos invalid: -2127991714
[   10.236957] bpfilter: write fail -22
[   10.236963] pos invalid: -2127991714
[   10.236964] bpfilter: write fail -22
[   10.237801] bpfilter: Loaded bpfilter_umh pid 1918
[   10.237856] Started bpfilter
[   10.238463] pos invalid: -2127991714
[   10.238465] bpfilter: write fail -22
[   10.238487] pos invalid: -2127991714
[   10.238488] bpfilter: write fail -22
[   10.239232] bpfilter: Loaded bpfilter_umh pid 1921
[   10.239293] Started bpfilter
[   10.239341] pos invalid: -131323777967304
[   10.239342] bpfilter: write fail -22
[   10.239362] pos invalid: -2127991714
[   10.239363] bpfilter: write fail -22
[   10.240024] bpfilter: Loaded bpfilter_umh pid 1923
[   10.240084] Started bpfilter
[   10.240136] pos invalid: -131322329686184
[   10.240137] bpfilter: write fail -22
[   10.240158] pos invalid: -2127991714
[   10.240159] bpfilter: write fail -22
[   10.240822] bpfilter: Loaded bpfilter_umh pid 1925
[   10.240885] Started bpfilter
[   10.240933] pos invalid: -131323778001336
[   10.240935] bpfilter: write fail -22
[   10.240955] pos invalid: -2127991714
[   10.240955] bpfilter: write fail -22
[   10.241625] bpfilter: Loaded bpfilter_umh pid 1927
[   10.241685] Started bpfilter
[   10.241732] pos invalid: -131323135926520
[   10.241733] bpfilter: write fail -22
[   10.241754] pos invalid: -2127991714
[   10.241754] bpfilter: write fail -22
[   10.242411] bpfilter: Loaded bpfilter_umh pid 1929
[   10.242472] Started bpfilter
[   10.242521] pos invalid: -131322329867000
[   10.242522] bpfilter: write fail -22
[   10.242544] pos invalid: -2127991714
[   10.242545] bpfilter: write fail -22
[   10.243204] bpfilter: Loaded bpfilter_umh pid 1931
[   10.243267] Started bpfilter
[   10.243314] pos invalid: -131322329851800
[   10.243315] bpfilter: write fail -22
[   10.243335] pos invalid: -2127991714
[   10.243335] bpfilter: write fail -22
[   10.244014] bpfilter: Loaded bpfilter_umh pid 1933
[   10.244079] Started bpfilter
[   10.244127] pos invalid: -131322329834712
[   10.244128] bpfilter: write fail -22
[   10.244148] pos invalid: -2127991714
[   10.244148] bpfilter: write fail -22
[   10.244809] bpfilter: Loaded bpfilter_umh pid 1935
[   10.244875] Started bpfilter
[   10.244923] pos invalid: -131323135845432
[   10.244924] bpfilter: write fail -22
[   10.244944] pos invalid: -2127991714
[   10.244944] bpfilter: write fail -22
[   10.245613] bpfilter: Loaded bpfilter_umh pid 1937
[   10.245677] Started bpfilter
[   10.245724] pos invalid: -131323135831656
[   10.245725] bpfilter: write fail -22
[   10.245753] pos invalid: -2127991714
[   10.245753] bpfilter: write fail -22
[   10.246426] bpfilter: Loaded bpfilter_umh pid 1939
[   10.246489] Started bpfilter
[   10.246536] pos invalid: -131323135812112
[   10.246537] bpfilter: write fail -22
[   10.246557] pos invalid: -2127991714
[   10.246557] bpfilter: write fail -22
[   10.247221] bpfilter: Loaded bpfilter_umh pid 1941
[   10.247283] Started bpfilter
[   10.247332] pos invalid: -131323135799288
[   10.247333] bpfilter: write fail -22
[   10.247353] pos invalid: -2127991714
[   10.247354] bpfilter: write fail -22
[   10.248028] bpfilter: Loaded bpfilter_umh pid 1943
[   10.248093] Started bpfilter
[   10.248141] pos invalid: -131322329819936
[   10.248142] bpfilter: write fail -22
[   10.248162] pos invalid: -2127991714
[   10.248163] bpfilter: write fail -22
[   11.683140] bpfilter: Loaded bpfilter_umh pid 1997
[   11.683214] Started bpfilter
[   11.683279] pos invalid: -131322964802512
[   11.683281] bpfilter: write fail -22
[   11.683325] pos invalid: -2127991714
[   11.683326] bpfilter: write fail -22
[   11.685772] bpfilter: Loaded bpfilter_umh pid 1999
[   11.685853] Started bpfilter
[   11.685961] pos invalid: -131323223158688
[   11.685964] bpfilter: write fail -22
[   11.686032] pos invalid: -2127991714
[   11.686033] bpfilter: write fail -22
[   11.687562] bpfilter: Loaded bpfilter_umh pid 2002
[   11.687623] Started bpfilter
[   11.688581] pos invalid: -2127991714
[   11.688584] bpfilter: write fail -22
[   11.688592] pos invalid: -2127991714
[   11.688593] bpfilter: write fail -22
[   11.689646] bpfilter: Loaded bpfilter_umh pid 2005
[   11.689731] Started bpfilter
[   11.689911] pos invalid: -2127991714
[   11.689913] bpfilter: write fail -22
[   11.689922] pos invalid: -2127991714
[   11.689923] bpfilter: write fail -22
[   11.690982] bpfilter: Loaded bpfilter_umh pid 2007
[   11.691047] Started bpfilter
[   11.691151] pos invalid: -2127991714
[   11.691154] bpfilter: write fail -22
[   11.691162] pos invalid: -2127991714
[   11.691163] bpfilter: write fail -22
[   11.692329] bpfilter: Loaded bpfilter_umh pid 2009
[   11.692407] Started bpfilter
[   11.693206] pos invalid: -2127991714
[   11.693208] bpfilter: write fail -22
[   11.693250] pos invalid: -2127991714
[   11.693251] bpfilter: write fail -22
[   11.694309] bpfilter: Loaded bpfilter_umh pid 2012
[   11.694369] Started bpfilter
[   11.694470] pos invalid: -131324827355584
[   11.694472] bpfilter: write fail -22
[   11.694519] pos invalid: -2127991714
[   11.694520] bpfilter: write fail -22
[   11.695513] bpfilter: Loaded bpfilter_umh pid 2014
[   11.695573] Started bpfilter
[   11.695669] pos invalid: -131324827335488
[   11.695672] bpfilter: write fail -22
[   11.695707] pos invalid: -2127991714
[   11.695708] bpfilter: write fail -22
[   11.696594] bpfilter: Loaded bpfilter_umh pid 2016
[   11.696667] Started bpfilter
[   11.696822] pos invalid: -131322940756688
[   11.696824] bpfilter: write fail -22
[   11.696876] pos invalid: -2127991714
[   11.696877] bpfilter: write fail -22
[   11.697871] bpfilter: Loaded bpfilter_umh pid 2018
[   11.697941] Started bpfilter
[   11.698039] pos invalid: -131323134120976
[   11.698042] bpfilter: write fail -22
[   11.698079] pos invalid: -2127991714
[   11.698080] bpfilter: write fail -22
[   11.698964] bpfilter: Loaded bpfilter_umh pid 2020
[   11.699041] Started bpfilter
[   11.699137] pos invalid: -131323134075224
[   11.699140] bpfilter: write fail -22
[   11.699197] pos invalid: -2127991714
[   11.699198] bpfilter: write fail -22
[   11.700053] bpfilter: Loaded bpfilter_umh pid 2022
[   11.700123] Started bpfilter
[   11.700233] pos invalid: -131326994695872
[   11.700236] bpfilter: write fail -22
[   11.700291] pos invalid: -2127991714
[   11.700292] bpfilter: write fail -22
[   11.701246] bpfilter: Loaded bpfilter_umh pid 2024
[   11.701307] Started bpfilter
[   11.701401] pos invalid: -131324827369352
[   11.701403] bpfilter: write fail -22
[   11.701439] pos invalid: -2127991714
[   11.701440] bpfilter: write fail -22
[   11.702315] bpfilter: Loaded bpfilter_umh pid 2026
[   11.702389] Started bpfilter
[   11.702484] pos invalid: -131322939518040
[   11.702487] bpfilter: write fail -22
[   11.702522] pos invalid: -2127991714
[   11.702523] bpfilter: write fail -22
[   11.703348] bpfilter: Loaded bpfilter_umh pid 2028
[   11.703423] Started bpfilter
[   11.703535] pos invalid: -131322939469856
[   11.703538] bpfilter: write fail -22
[   11.703573] pos invalid: -2127991714
[   11.703574] bpfilter: write fail -22
[   11.704497] bpfilter: Loaded bpfilter_umh pid 2030
[   11.704572] Started bpfilter
[   11.704666] pos invalid: -131322939428640
[   11.704668] bpfilter: write fail -22
[   11.704718] pos invalid: -2127991714
[   11.704719] bpfilter: write fail -22
[   11.705536] bpfilter: Loaded bpfilter_umh pid 2032
[   11.705605] Started bpfilter
[   11.705700] pos invalid: -131322939385792
[   11.705702] bpfilter: write fail -22
[   11.705738] pos invalid: -2127991714
[   11.705739] bpfilter: write fail -22
[   11.706598] bpfilter: Loaded bpfilter_umh pid 2034
[   11.706666] Started bpfilter
[   11.706740] pos invalid: -131322939340512
[   11.706741] bpfilter: write fail -22
[   11.706768] pos invalid: -2127991714
[   11.706768] bpfilter: write fail -22
[   13.141791] bpfilter: Loaded bpfilter_umh pid 2086
[   13.141840] Started bpfilter
[   13.141919] pos invalid: -131323223055336
[   13.141920] bpfilter: write fail -22
[   13.141983] pos invalid: -2127991714
[   13.141984] bpfilter: write fail -22
[   13.144245] bpfilter: Loaded bpfilter_umh pid 2088
[   13.144312] Started bpfilter
[   13.144418] pos invalid: -131340777111464
[   13.144420] bpfilter: write fail -22
[   13.144457] pos invalid: -2127991714
[   13.144458] bpfilter: write fail -22
[   13.145931] bpfilter: Loaded bpfilter_umh pid 2091
[   13.146005] Started bpfilter
[   13.146859] pos invalid: -2127991714
[   13.146861] bpfilter: write fail -22
[   13.146869] pos invalid: -2127991714
[   13.146870] bpfilter: write fail -22
[   13.147936] bpfilter: Loaded bpfilter_umh pid 2094
[   13.148012] Started bpfilter
[   13.148142] pos invalid: -2127991714
[   13.148144] bpfilter: write fail -22
[   13.148152] pos invalid: -2127991714
[   13.148153] bpfilter: write fail -22
[   13.149176] bpfilter: Loaded bpfilter_umh pid 2096
[   13.149249] Started bpfilter
[   13.149375] pos invalid: -2127991714
[   13.149377] bpfilter: write fail -22
[   13.149385] pos invalid: -2127991714
[   13.149386] bpfilter: write fail -22
[   13.150281] bpfilter: Loaded bpfilter_umh pid 2098
[   13.150338] Started bpfilter
[   13.151152] pos invalid: -2127991714
[   13.151154] bpfilter: write fail -22
[   13.151181] pos invalid: -2127991714
[   13.151182] bpfilter: write fail -22
[   13.151976] bpfilter: Loaded bpfilter_umh pid 2101
[   13.152039] Started bpfilter
[   13.152138] pos invalid: -131327007189936
[   13.152140] bpfilter: write fail -22
[   13.152177] pos invalid: -2127991714
[   13.152178] bpfilter: write fail -22
[   13.153016] bpfilter: Loaded bpfilter_umh pid 2103
[   13.153090] Started bpfilter
[   13.153193] pos invalid: -131322273461040
[   13.153196] bpfilter: write fail -22
[   13.153238] pos invalid: -2127991714
[   13.153239] bpfilter: write fail -22
[   13.154129] bpfilter: Loaded bpfilter_umh pid 2105
[   13.154207] Started bpfilter
[   13.154318] pos invalid: -131322273403824
[   13.154320] bpfilter: write fail -22
[   13.154363] pos invalid: -2127991714
[   13.154364] bpfilter: write fail -22
[   13.155105] bpfilter: Loaded bpfilter_umh pid 2107
[   13.155178] Started bpfilter
[   13.155276] pos invalid: -131340782823592
[   13.155279] bpfilter: write fail -22
[   13.155313] pos invalid: -2127991714
[   13.155314] bpfilter: write fail -22
[   13.156060] bpfilter: Loaded bpfilter_umh pid 2109
[   13.156140] Started bpfilter
[   13.156221] pos invalid: -131340782780136
[   13.156223] bpfilter: write fail -22
[   13.156271] pos invalid: -2127991714
[   13.156272] bpfilter: write fail -22
[   13.157018] bpfilter: Loaded bpfilter_umh pid 2111
[   13.157089] Started bpfilter
[   13.157198] pos invalid: -131323223027832
[   13.157200] bpfilter: write fail -22
[   13.157265] pos invalid: -2127991714
[   13.157266] bpfilter: write fail -22
[   13.158051] bpfilter: Loaded bpfilter_umh pid 2113
[   13.158138] Started bpfilter
[   13.158249] pos invalid: -131322419105776
[   13.158252] bpfilter: write fail -22
[   13.158307] pos invalid: -2127991714
[   13.158308] bpfilter: write fail -22
[   13.159041] bpfilter: Loaded bpfilter_umh pid 2115
[   13.159113] Started bpfilter
[   13.159208] pos invalid: -131323223046528
[   13.159210] bpfilter: write fail -22
[   13.159245] pos invalid: -2127991714
[   13.159246] bpfilter: write fail -22
[   13.159991] bpfilter: Loaded bpfilter_umh pid 2117
[   13.160085] Started bpfilter
[   13.160181] pos invalid: -131324280863928
[   13.160184] bpfilter: write fail -22
[   13.160241] pos invalid: -2127991714
[   13.160242] bpfilter: write fail -22
[   13.160999] bpfilter: Loaded bpfilter_umh pid 2119
[   13.161074] Started bpfilter
[   13.161156] pos invalid: -131322939045512
[   13.161158] bpfilter: write fail -22
[   13.161195] pos invalid: -2127991714
[   13.161195] bpfilter: write fail -22
[   13.161931] bpfilter: Loaded bpfilter_umh pid 2121
[   13.162004] Started bpfilter
[   13.162101] pos invalid: -131323079063632
[   13.162103] bpfilter: write fail -22
[   13.162139] pos invalid: -2127991714
[   13.162140] bpfilter: write fail -22
[   13.162886] bpfilter: Loaded bpfilter_umh pid 2123
[   13.162956] Started bpfilter
[   13.163053] pos invalid: -131340782774864
[   13.163055] bpfilter: write fail -22
[   13.163091] pos invalid: -2127991714
[   13.163092] bpfilter: write fail -22

After that, the bpfilter output rests.

If I try to start docker, then new bpfilter errors as the ones above are
printed again, with increasing PIDs and similar pseudo-random-looking
positions. I have not tested with other bpfilter-using programs.

Let me know if my system has any information that might help in this matter.

Best regards,
Madera


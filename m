Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379F12076D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTqEr0vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHRASD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHRASB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:18:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B8C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:18:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w25so19411125ljo.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LdsjObCAX5Kb4UTHQq0gRsy2DSTJwMMoBCDl3JdgqEE=;
        b=cTqEr0vyoDyQtbVoirAqD3kXkqXQ/Tg99YLssgivk3xLWH/VKSO8ooFF6B+628Cxef
         WShnE93lpIf3iNPk0FCyz3CtN4XGwLwD312lT4cNzY1uRk/vN//5etahCNALNRNINCDi
         2MMM+7/lMlWbhB6D+0k+RPWpjJ7CqI7cYB+pu4h4dsxHSImfVKL9KIwoUsoVKu8hjHEV
         hs6HDw0XzoyMKn404XGcmHLuwlZ5Q1NkznSmChF/SjiSwzcXVeOVRpzV6Zx9v1g9mzap
         IZgPp/jt81pwgwbSeciuXY/tbmDH1HEsEwBFNL0JibhTyt+spBSk/B4btoTTVHyycrOs
         YvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LdsjObCAX5Kb4UTHQq0gRsy2DSTJwMMoBCDl3JdgqEE=;
        b=TM8Bwpup+NiW+LyZzTVWrzfQsujSTbA3KjLfVcyN5v+Vhh1kI6zCfGIQv+Pd0K44IH
         ZXu97ZOfZqucuwVzIHUWfqUx7TvcC69VkyK2XO1r+L0cUInr2LaLq5j5y3V134TfhQU4
         rnWfjCe4Un+1zMWlquULK0Z8DI0sw8PqkT9Q/zDxCvVOwlpnBi7SS+vyU6kZgdQsnH4q
         zW39UtrWsKEGTt9QhtSX6A89aLTH0skIuwQnYBvINSFh7PwLCcYAcbiOQazKIOAPR9RE
         LPLYBmj2Top73k5b8iw0lQ2FUEKlAUB9QgRfz79Kd1EXHz+p9eiwv7l6fbDB/lclNvqM
         SbkQ==
X-Gm-Message-State: AOAM5334rsqAfzrjklOQUy2V99Sx1vMZOeLcLAqsvCPGlsBVDsLToU9U
        M1ppnriQbJAUprBnXLwi0CU=
X-Google-Smtp-Source: ABdhPJwbbuJkcgmWMr6m8HBCqjYvoq0MFe73AzlCI1RTpR3xNZOua4o2FFGGK1voJbbE6I/5hxxOEQ==
X-Received: by 2002:a2e:8e9a:: with SMTP id z26mr7965868ljk.271.1597709879364;
        Mon, 17 Aug 2020 17:17:59 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id a23sm5364034ljp.121.2020.08.17.17.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 17:17:58 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] dt-bindings: mfd: Add ENE KB3930 Embedded
 Controller binding
To:     Lubomir Rintel <lkundrak@v3.sk>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20200709231228.11564-1-lkundrak@v3.sk>
 <20200709231228.11564-2-lkundrak@v3.sk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6521970d-8aea-ddbb-e9d7-8b072a685872@gmail.com>
Date:   Tue, 18 Aug 2020 03:17:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709231228.11564-2-lkundrak@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.07.2020 02:12, Lubomir Rintel пишет:
> Add binding document for the ENE KB3930 Embedded Controller.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v5:
> - s/a I2C bus/an I2C bus/
> 
> Changes since v4:
> - Collected Rob's Reviewed-by
> 
> Changes since v1:
> - Addressed binding validation failure
> ---

Hello! I'm happy that I noted this patch on the ML because I'm preparing
patches that will add support for KB930, which is compatible with
KB3930. Will be nice to see this patch applied ASAP! I'm going to extend
this binding with the KB930.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

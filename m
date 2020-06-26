Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B676C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C8920702
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="aXUNBRHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgFZPx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgFZPxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:53:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126EEC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i3so10876350ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wS3ZoLwVxMYE5aOSMJlL4wxZx5NfasIcwsCreNsKCHg=;
        b=aXUNBRHApb/d4chCFqPEAPBCerd3HA1AvzgBAtxqWUNfOP2ounPi0BGuHU/6m1fMLy
         iZUgVzdo4eoyvRyCiukLyt5m7teU8Bt/nXESIblqrPBS8siY3NlycbomLgD6F4O97yVX
         Yc6EqjHlhno2UoZfMpghdRCPxOK8hvq8MMShIZpLFyWt+ICmU5qANsip6istpwh2ATbS
         7TJoAXNg7C+bWwqwIZ2bFiKsNqC4/dosBpHgjQKhtBrYHYNiUoePWmDXvonUWiz36CvB
         SBybpbeMe/pSr54YHQuY0qFNbrQn5/1Pu5ViKf1lJa4+hB4rJnGLh5593rzpjFuoFwXO
         B5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wS3ZoLwVxMYE5aOSMJlL4wxZx5NfasIcwsCreNsKCHg=;
        b=gCFPI/6Jje0yMk8CmM75+D9jCOMVui/Rag7077yNtaTkkMywoZR1ZhYLWZnkWWin6o
         A1OBTQkZ85nU557bYJOHeyPItlN/t/GpUDbk9lrRhQya+b/RyBwpea4bRrtspxyL4yhH
         2lcHWZbc/dhbb0WFW8vVXuZA3eQTIdi8yDbmZ9uLxMKwFBy8AFL/1vNNTrFjK650YYfU
         7m+o/M+EJbQvEoBR59Ju0AmdzUWCj9T+rX1kvNt4/f1htjxJyuIiBdyYCvdu2wrVhxM/
         JO8BXY84XXfZrsAw7/pWtWA+xg5dtAglJ05pWsdnXEZuF7tGg1l66yLYCkdgp1xmtgSI
         uMSA==
X-Gm-Message-State: AOAM530okmvnGMcDuF/8KE8ALT6pTHLdKAhdNOC+7luawwd+D8Dge07b
        +Hu6CoizJVkhkMbSBuUK3yeNXg==
X-Google-Smtp-Source: ABdhPJxVanab6IRVSKzmHEyKsqu6Hh1aLxUPDUAS04E63YfmDijCpVv/qdoDyztglfWI0L3Z931Ieg==
X-Received: by 2002:a2e:a548:: with SMTP id e8mr1822890ljn.76.1593186833518;
        Fri, 26 Jun 2020 08:53:53 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4807:b213:5663:e485:3cf8:764f])
        by smtp.gmail.com with ESMTPSA id d6sm2733412lja.77.2020.06.26.08.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jun 2020 08:53:52 -0700 (PDT)
Subject: Re: [PATCH/RFC v4 3/4] mmc: core: Call mmc_poweroff_nofity() if
 regulators are disabled
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        ulf.hansson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1593163942-5087-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <059bced3-00d3-cf2e-6628-a8c9f1544909@cogentembedded.com>
Date:   Fri, 26 Jun 2020 18:53:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1593163942-5087-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06/26/2020 12:32 PM, Yoshihiro Shimoda wrote:

> If regulator_is_enabled() of both vmmc and vqmmc returns false,
> _mmc_suspend() should call mmc_poweroff_nofity() instead of
                                          ^^^^^^
  That hard word again. :-)        

> mmc_sleep().
> 
> Note that this is possible to happen when the regulator-fixed driver
> turns the vmmc and vqmmc off by firmware like PSCI while the system
> is suspended.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[...]

MBR, Sergei

Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A2FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5D82075A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLLAPN0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgFGSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgFGSSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:18:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C7C061A0E;
        Sun,  7 Jun 2020 11:18:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ga6so4805885pjb.1;
        Sun, 07 Jun 2020 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7kdvnHlI2BwcLUZyuEbfKTWscMNJHH9ee5Bw6DTM0s0=;
        b=MLLAPN0rloCpwl/H+H50DYoUuFDcMFe4LjMpQcQKjVp7AsVLKpaGQaQF/TAb3V4GQK
         MpTDxJAwdkEkmTXsQy8YqlMKM77u6ZvBri1O/79AOs8b4l5/L+SdCm2dgxuZKpc98XQa
         lFLnkUFaKuwxm8j+3Klfy1eiB5fXoZ/JYB7qZ9D3lSHYnYaQ+ww1Qp69T8owjuC8dBso
         9mwMuYv5MtmJ4PP+cGMpo1Bi/wW2aObQVJyor+sOEn+MCTy5uHaGQ9XdzyBZmywiIiju
         f2V2JMbnLuGhds2GYo8w6/q2c37fkwnnRSZdrZxOJ+Cffc4pshrlEiB9P9CyldvhmN+S
         odWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7kdvnHlI2BwcLUZyuEbfKTWscMNJHH9ee5Bw6DTM0s0=;
        b=tLdDvfkXfVi4XWweh71K2y09WypkNv669fOPaP+KRKQTx3sTmIYux9D4t2QyA2p79f
         /lgpY0iHOBlKj8F2nYcPRmHInOjPb96FMrtljrkEmWXnLqSoOGTwe88DFhv3VXA/yYds
         ZTW/WELdsw5gWTuwC/VRB4x5HL8SDdnFYTVgY2bfB1h+xqSnR2bWUI0CTKjlDztWmsNJ
         iE57lHC2G8x73TFJi9FIbfpawynCnrLkNRjfXYyMAdHLlM2lC65Dpe85Dy57YFOFDZjq
         77+AUT9+7qIRq2qG40IBH9lveKDH1/POzD1ciMjk9ncDVWqE8avr+vBgXJqxdgsz6kQh
         X5TA==
X-Gm-Message-State: AOAM531MM/PYA1iy4PZDqqIrO/lFx7v2KX7bOEvEcSlJSI99n4VymjhV
        cmRb8nA6FQc2naRswdh57365CK8C
X-Google-Smtp-Source: ABdhPJz4E+N5CNlpCT9hbEQGsCAHEfxCz0zVo3m4wayzb29MMsjj/j3ovHVYXQMa+VkkTCymw8tHww==
X-Received: by 2002:a17:90b:1013:: with SMTP id gm19mr13660212pjb.231.1591553908769;
        Sun, 07 Jun 2020 11:18:28 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id h8sm4986492pfo.67.2020.06.07.11.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 11:18:28 -0700 (PDT)
Subject: Re: [RFC PATCH net-next 09/10] selftests: forwarding:
 forwarding.config.sample: Add port with no cable connected
To:     Amit Cohen <amitc@mellanox.com>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, corbet@lwn.net,
        jiri@mellanox.com, idosch@mellanox.com, shuah@kernel.org,
        mkubecek@suse.cz, gustavo@embeddedor.com,
        cforno12@linux.vnet.ibm.com, andrew@lunn.ch,
        linux@rempel-privat.de, alexandru.ardelean@analog.com,
        ayal@mellanox.com, petrm@mellanox.com, mlxsw@mellanox.com,
        liuhangbin@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200607145945.30559-1-amitc@mellanox.com>
 <20200607145945.30559-10-amitc@mellanox.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0e99b918-07aa-d91a-a19e-d3c4958d06ea@gmail.com>
Date:   Sun, 7 Jun 2020 11:18:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200607145945.30559-10-amitc@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/2020 7:59 AM, Amit Cohen wrote:
> Add NETIF_NO_CABLE port to tests topology.
> 
> The port can also be declared as an environment variable and tests can be
> run like that:
> NETIF_NO_CABLE=eth9 ./test.sh eth{1..8}
> 
> The NETIF_NO_CABLE port will be used by ethtool_extended_state test.
> 
> Signed-off-by: Amit Cohen <amitc@mellanox.com>
> Reviewed-by: Petr Machata <petrm@mellanox.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

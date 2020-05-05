Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB2EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAAB206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="bEgemimG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgEEAFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 20:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEEAFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 20:05:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91654C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 17:05:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h12so461378pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 17:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJisQVo+doMecpLYDgXbLnuJk8fwWTr3ooCXVB5wUoA=;
        b=bEgemimGj7IRspISKSzcTlqaOWHAl6fmTwOvgtr3AN4Em7/FE7pp6vcnz7jJ4QwhdI
         RytS6X7kee8K2g9n5YfWAMVERGszoIn7UpmVu7QoqjkJwmaTfWPx1tbaMuzluWwDPRFq
         u+DIL3owBzu3hyp8p0fQyCYbW//9GObS3dO1fd9RWGy7KUyRO1+nygmCxOyQHim0pbXx
         FxfRwcvKgX0WDmplcTe6MEbKgbddDFlrczf0uAZ2QFv5vDS8BRjctqni5IdECGAjFPEm
         bMhBd6Z8ZBn6xr2bF4D4gqnvQyGUeK8NKNHU20aVDRGg7wtgkUcJ12rmK55LXq6GIiNR
         ns1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJisQVo+doMecpLYDgXbLnuJk8fwWTr3ooCXVB5wUoA=;
        b=Z2hOYO214vS0mwAs/eJKz2gg+LNdqOyCafaAFZQuRmBQ8JJeoOj0FY3uO/YLj6RNQI
         C082Hjthv5LZwA1HBy7wz3RBZ2AoUoFWJv3S2WHZkGbnltTDU8JorACFMmUL2jZKm3OC
         7ZP6ni6gVlZx6Fce5duofwApynWguOBUBns3KoZr7RJvQAaFJobTICl6rfTlx/0pZU6N
         voryPBCUUDmzSMO/F4tvoBZsf+7L6+XnzJfZrbLYyLyl90L1JAKmLr3u8MnrBnFZ4c5f
         npmMeHhXsMaMYIKrAayheQ4T1UNEGSuXbfNtZvZ+DSiNzqwkFqooZ6Bdu8NgWL2qk6+h
         QyNA==
X-Gm-Message-State: AGi0PuYaXgIvPXrknEUo+ojHh5LNWJKLJHi6TvabpLE5xWvFo30+hwbZ
        bG0FF2p//xaufJXD2s3ztseiKQ==
X-Google-Smtp-Source: APiQypLxIOTVNo8eLemhfWKUgu3c4328NsfUjwNsLd0y3N+j/UzZI2PMItToOZNaf2Stvx3eOnErfA==
X-Received: by 2002:a17:902:361:: with SMTP id 88mr204608pld.279.1588637121607;
        Mon, 04 May 2020 17:05:21 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id b13sm223058pfo.67.2020.05.04.17.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 17:05:21 -0700 (PDT)
Date:   Mon, 4 May 2020 17:05:12 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Po Liu <Po.Liu@nxp.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, vinicius.gomes@intel.com, vlad@buslov.dev,
        claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
        alexandru.marginean@nxp.com, michael.chan@broadcom.com,
        vishal@chelsio.com, saeedm@mellanox.com, leon@kernel.org,
        jiri@mellanox.com, idosch@mellanox.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        kuba@kernel.org, xiyou.wangcong@gmail.com,
        simon.horman@netronome.com, pablo@netfilter.org,
        moshe@mellanox.com, m-karicheri2@ti.com,
        andre.guedes@linux.intel.com
Subject: Re: [v3,iproute2 1/2] iproute2:tc:action: add a gate control action
Message-ID: <20200504170512.74505a82@hermes.lan>
In-Reply-To: <20200503063251.10915-1-Po.Liu@nxp.com>
References: <20200501005318.21334-5-Po.Liu@nxp.com>
        <20200503063251.10915-1-Po.Liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 May 2020 14:32:50 +0800
Po Liu <Po.Liu@nxp.com> wrote:

> Introduce a ingress frame gate control flow action.
> Tc gate action does the work like this:
> Assume there is a gate allow specified ingress frames can pass at
> specific time slot, and also drop at specific time slot. Tc filter
> chooses the ingress frames, and tc gate action would specify what slot
> does these frames can be passed to device and what time slot would be
> dropped.
> Tc gate action would provide an entry list to tell how much time gate
> keep open and how much time gate keep state close. Gate action also
> assign a start time to tell when the entry list start. Then driver would
> repeat the gate entry list cyclically.
> For the software simulation, gate action require the user assign a time
> clock type.
> 
> Below is the setting example in user space. Tc filter a stream source ip
> address is 192.168.0.20 and gate action own two time slots. One is last
> 200ms gate open let frame pass another is last 100ms gate close let
> frames dropped.
> 
>  # tc qdisc add dev eth0 ingress
>  # tc filter add dev eth0 parent ffff: protocol ip \
> 
>             flower src_ip 192.168.0.20 \
>             action gate index 2 clockid CLOCK_TAI \
>             sched-entry open 200000000 -1 -1 \
>             sched-entry close 100000000
> 
>  # tc chain del dev eth0 ingress chain 0
> 
> "sched-entry" follow the name taprio style. Gate state is
> "open"/"close". Follow the period nanosecond. Then next -1 is internal
> priority value means which ingress queue should put to. "-1" means
> wildcard. The last value optional specifies the maximum number of
> MSDU octets that are permitted to pass the gate during the specified
> time interval.
> 
> Below example shows filtering a stream with destination mac address is
> 10:00:80:00:00:00 and ip type is ICMP, follow the action gate. The gate
> action would run with one close time slot which means always keep close.
> The time cycle is total 200000000ns. The base-time would calculate by:
> 
>      1357000000000 + (N + 1) * cycletime
> 
> When the total value is the future time, it will be the start time.
> The cycletime here would be 200000000ns for this case.
> 
>  #tc filter add dev eth0 parent ffff:  protocol ip \
>            flower skip_hw ip_proto icmp dst_mac 10:00:80:00:00:00 \
>            action gate index 12 base-time 1357000000000 \
>            sched-entry CLOSE 200000000 \
>            clockid CLOCK_TAI
> 
> Signed-off-by: Po Liu <Po.Liu@nxp.com>

These changes are specific to net-next should be assigned to iproute2-next.
Will change delegation.


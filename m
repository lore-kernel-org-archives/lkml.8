Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF912C3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A1F206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="K/jDCz/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgEEAGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 20:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEEAGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 20:06:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ACEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 17:06:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h11so62777plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUV5nGTsoQznCDI+5MIptHShSeOOp2WTJ5qCLRg1Mvk=;
        b=K/jDCz/0ARQlzavv7xQrjbfGY5MvHEzrfkpsYktY/Cd5pvAF2aTfCCQczqM6pwD9h5
         VLOmzVH3YJF9hLbrmWf0OxSalpnjSLDd/XlycYEzQrID0bLO0wRK+QqaUXZ2kMq64Yf/
         2YBg9+a6fO9xMq6+DZ8GjppUxxVhGXYaJuZii1LZl1dAKf1sgHRSJflS20Kc3VJnE2lo
         9v43+u/ugHDa3yLCH+aM9O9i2d4r3GCoVUxdfszO2k+7HKOefnNwum0x5aW5YzTl+5IO
         XfIuhZ7wTFeMIoFwMMWpXG+hpMVqEtEG6CD5SFSRoF6k5Ju+i+WFjJHIov6qQiF8POIz
         jN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUV5nGTsoQznCDI+5MIptHShSeOOp2WTJ5qCLRg1Mvk=;
        b=lwm3OM745FMw8MnjnI5dszWUMoDrBE9+QpIXzhJ1eVgaojgrI5AqBU0DjSkNiFvwdM
         0R7mou0W8GH/zlqU1LRlW0e/Zjyj5tdw63CekKz6CHgg2967ldt+DyVXZWvrIe++OYIv
         ko9WORRtfN/FOzUbRs1903xKGwExOgnhNknvq3K/kYFJFbBYlls10sSr8wAHgX5BmUBX
         L/gnbOmIMkaytsSKPSwTnkqvEbrR5rMyPqCuxhq9h0erxhDLe0obeDfame2NnMopAHAw
         IG0S4betucfe/2RfvSbXzaUymv44faJVJVPL56nGmcbtBv0FcRJVR9q3Vx+8dfVf7NKx
         ZKug==
X-Gm-Message-State: AGi0PubJyfIuwuyj345GmlzfABrepYU0AT9DX940dhYTbtqyPDnUGF79
        eeyCx27cdBWdCKMRgX3OypbZ4g==
X-Google-Smtp-Source: APiQypJdo40fcYrMhZ2BwW2fhbYADmT+J28Da7TFAOxNLG4Istb1ih9pbTxYcsz26R7Y1izmEhJV3A==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr227984plz.127.1588637200388;
        Mon, 04 May 2020 17:06:40 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id e12sm185689pgv.16.2020.05.04.17.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 17:06:40 -0700 (PDT)
Date:   Mon, 4 May 2020 17:06:37 -0700
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
Message-ID: <20200504170637.3f723496@hermes.lan>
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

> +		print_string(PRINT_ANY, "gate state", "\tgate-state %-8s",

NAK
Space in a json tag is not valid.

Please run a dump command and feed it into JSON validation checker like Python.

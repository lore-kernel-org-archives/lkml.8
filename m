Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D65C47257
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DCA21775
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="1+Cjd90d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgEJBBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 21:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEJBBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 21:01:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389B3C061A0E
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 18:01:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so2346413pls.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uSW1DMa2xFD1JwY5E5sO8XesFCa8M5X82K6mPTFeOlM=;
        b=1+Cjd90dDpebl/lpjqKbNVokRT3OdtBCX464eur5zMRwc6sunR//0hTPKyGFMBYDn+
         4s4EMDlJoNIkNgtkCHvFKvJ4BK+FSLcJcF3J0h1lFBJHpcGvBOOdoVJNuJuduxyhdptA
         85j0f2zkLQyxEd/osyueYryePBBEKaHhfTf3pYUcyugloMOdyrOAfoJZ6gWHbUrjqQLj
         Bq4Jez4NN0LmXePlsppUQ+3lVV2FHHGMRHWmUEdUPVdDZtvm3xP30rhd+ijoCYftHXaH
         O/d9SbqFvB9iV52JjhqLOrwxcvZn53+35Gt30HqnEMHSXevbw+tJGlyzQoU9D+YGA4+g
         K2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uSW1DMa2xFD1JwY5E5sO8XesFCa8M5X82K6mPTFeOlM=;
        b=YAnzJvLZjr1OLPiD4rxFzpyIddsAjCZ4veLKDG6r8Rp2W8KbyrKoSL7r68pSIalvNI
         GcABLN3/m9XTKXWxtSBDacJATxOVr8t7o0ZGVfbbeuLT+TfSKlmnI9TvtlUGyDziyYp/
         224x6GF8Lcn+CGmehY6ePNl7BtWgZZpOzwUJan+3fxNoh/g1mspk//srjf//RZ3u4eQg
         ammhtDE8ljXom5lP4hfGaMfT36EWnDNkyEGfglF+DULqOJ20ysC13v7Lp5CRXiuv7cwb
         LYSx6i/rmU9xfPQqTIQeVAV5EkchF5c2Y4wcF6syP7N69U4ym0gIXLSL/PglEgcALaTV
         PQlw==
X-Gm-Message-State: AGi0PuY9awP2YgqzxgrLMDf+bZRs8qIAO/NJyEGt4cmULVDM3Jo5M4UE
        IxNUuPXYixXQGSTevkLBp6YaAo85PIgO8A==
X-Google-Smtp-Source: APiQypK4urdSWKHAH3Iuz6cUfY7VBxMl/PQZvd82MG6IPFOmlk+5A2FE/bq13Bz5zOp9Fvriq0citA==
X-Received: by 2002:a17:902:8545:: with SMTP id d5mr9040836plo.34.1589072514404;
        Sat, 09 May 2020 18:01:54 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id b1sm5478906pfi.140.2020.05.09.18.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 18:01:53 -0700 (PDT)
Subject: Re: [PATCH 00/15] net: taint when the device driver firmware crashes
To:     Luis Chamberlain <mcgrof@kernel.org>, jeyu@kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200509043552.8745-1-mcgrof@kernel.org>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <1e097eb0-6132-f549-8069-d13b678183f5@pensando.io>
Date:   Sat, 9 May 2020 18:01:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200509043552.8745-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 9:35 PM, Luis Chamberlain wrote:
> Device driver firmware can crash, and sometimes, this can leave your
> system in a state which makes the device or subsystem completely
> useless. Detecting this by inspecting /proc/sys/kernel/tainted instead
> of scraping some magical words from the kernel log, which is driver
> specific, is much easier. So instead this series provides a helper which
> lets drivers annotate this and shows how to use this on networking
> drivers.
>
If the driver is able to detect that the device firmware has come back 
alive, through user intervention or whatever, should there be a way to 
"untaint" the kernel?  Or would you expect it to remain tainted?

sln


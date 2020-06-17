Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F47C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6C52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yq/UKsYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFQTHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFQTHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:07:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A13C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:07:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id q14so2433164qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hExgXDZV3zpYGtiPY9jV9AWM1I/0OncMTJ8ouUg465o=;
        b=Yq/UKsYvS0A5josQgPU+0t/qeW1UDwyO90aOpKP5PVYKTVQERWgvbxo7N6o4rLyGJV
         jaouHK6XMXK4ToLxdbxpdYbs+FMmvt3Z4AyrWrXMOans4RMyzqar+6OvBPnP0VW9A7oP
         lWU9WTEMPcH3OhvGA4Fdx4JuxoIj5K1Ll88ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hExgXDZV3zpYGtiPY9jV9AWM1I/0OncMTJ8ouUg465o=;
        b=OshCmK3GjvUuWQ1ep+rT5ALyb9BH+qsEzRKt47m/jokmSONZZyU+QU9nv8yatV1cDN
         Rabae7sy5RSi35UqFwxw8Gqz/hd9MBzNfMbnYQUo3pU1x1tyJre+DP4EEgWpehAe5IXh
         AXiks5mvscQxnrIbZTaJErTFKPshTQ14fkpdF1VMrOq8LGK5slhXzYLK7ExDZnTweaEf
         tkZ2dyg9mLE/Z4Ky5jaU8ldmkoNqA0HByJ47yUugW7kjAGd3w6RzePb9BPTngPvf7XFn
         RlMbtubFZu5lM8uqlEaFycnLGKY9upcD7cr5TufUXX0wjKdX6RIoPQkt4qQzEo3dk+JU
         IUpg==
X-Gm-Message-State: AOAM531+oPIdXfqTuwIexiURlNauVDpgPg8EN2xtqvLfsydb59Tjnz9z
        WcyqwSoSwk4QQpIAFZtCWkN0jg1T8whNDjlhsHD8dg==
X-Google-Smtp-Source: ABdhPJw2/X6M0huZ3wYR/5SR5uzm7PonmG3PRzsJ0BS0PeITaIZxz6pdiPRuA7pGlJKolACxFYkIkvqmU79DWDg14Qs=
X-Received: by 2002:aed:3fa4:: with SMTP id s33mr663234qth.148.1592420840377;
 Wed, 17 Jun 2020 12:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200615190119.382589-1-drc@linux.vnet.ibm.com> <20200617185117.732849-1-drc@linux.vnet.ibm.com>
In-Reply-To: <20200617185117.732849-1-drc@linux.vnet.ibm.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Wed, 17 Jun 2020 12:07:08 -0700
Message-ID: <CACKFLimXALz8LOPFiX7ar456CsucUf-wxmD4_KkJSmjXbZ-q+w@mail.gmail.com>
Subject: Re: [PATCH v2] tg3: driver sleeps indefinitely when EEH errors exceed eeh_max_freezes
To:     David Christensen <drc@linux.vnet.ibm.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:51 AM David Christensen
<drc@linux.vnet.ibm.com> wrote:
>
> The driver function tg3_io_error_detected() calls napi_disable twice,
> without an intervening napi_enable, when the number of EEH errors exceeds
> eeh_max_freezes, resulting in an indefinite sleep while holding rtnl_lock.
>
> Add check for pcierr_recovery which skips code already executed for the
> "Frozen" state.
>
> Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Thanks.

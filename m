Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876C5C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C222465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583830528;
	bh=2sdxtpswuMghQi2CqrS8nbarm5BBY7Twk1RfEVxSRME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=adcycJvZEUOVc8VbI/Thc/b9W09Gcsy/nqEyv/Fb4JpO0wCfF/CdtfpR9hAKM5ess
	 Roq/7g0p3oCLugJUnMSBHYbPgV4MrgUHUkPlSTvhSPxpFeiTZgGJnXWCCoJ82SkL7V
	 mB89C4zJR76kr/+US+YFJymjM935eDg3ahHMh6ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCJIz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:55:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42844 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJIz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:55:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id l12so13048484oil.9;
        Tue, 10 Mar 2020 01:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sdxtpswuMghQi2CqrS8nbarm5BBY7Twk1RfEVxSRME=;
        b=XaZP7UlgED3ejJpsWPXpBh6qStBgKfcasuZZXe9qbxfXtqoh9Ua+13n8ZkhwL+cj3g
         PNIiCbol0PcZbxu/iNYPERHE/QD9SkU1nywBVEzh9zOE7JRSidKBjiXlT/RCm7TC5dCa
         A4V68sIf6rXOj3gWLPAP2JUBXqbZCPJnRDyHqcqFB+H17DmAIoob0aVd/EryalTHpqAz
         vOW2I0rgM6ELh4K3d5+WL1k85UgEPovalQ4qgV7rYUZcMGpT7Sk+t0Nj/qS+SuLEFvRF
         w9jAQCDKRbJC//13+ZTZ/FNGMQMBDK8xj2gcRjM4SFBfO6/KwebWn4wiCGFeIyzOlnGl
         PN2A==
X-Gm-Message-State: ANhLgQ34+KixIUd2pJeP7jDCz2dbPrnft76NUtd9oFOzsi++vQhE4Pfi
        27fYXY7ZFFpzfy+aXLTGsBmY7YDOqZ3XG1vpTayYeA==
X-Google-Smtp-Source: ADFU+vtHqBwQVlPlHwGR60IzGRtmFCmsCWjXRcUW7nbupazhD/5nD53PM9w490GIIaN84xdF3KO7cjRDU8OA+N0lj+I=
X-Received: by 2002:aca:5155:: with SMTP id f82mr384236oib.103.1583830526316;
 Tue, 10 Mar 2020 01:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <fcbb3dc4-38ae-8361-bd6b-a00ae00c189c@linuxfoundation.org>
In-Reply-To: <fcbb3dc4-38ae-8361-bd6b-a00ae00c189c@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Mar 2020 09:55:15 +0100
Message-ID: <CAJZ5v0jqTGE5zBnwijjWbze4fuDW_h3muV9X1=EHbeHMqcF2JQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.6-rc6
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Gilbert <floppym@gentoo.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Renninger <trenn@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Sat, Mar 7, 2020 at 1:14 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 5.6-rc6.
>
> This cpupower update for Linux 5.6-rc6 consists of a fix from
> Mike Gilbert for build failures when -fno-common is enabled.
> -fno-common will be default in gcc v10.
>
> Diff is attached.

Pulled, thanks!

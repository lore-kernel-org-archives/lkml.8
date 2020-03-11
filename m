Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL_NO_RDNS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44004 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgCKQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:36:03 -0400
Subject: Re: [PATCH -next 030/491] BROADCOM GENET ETHERNET DRIVER: Use
 fallthrough;
To: Joe Perches <joe@perches.com>, Doug Berger <opendmb@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583896344.git.joe@perches.com>
 <e78fb08d1dcf0d95175fc2866c344fbef2ff7065.1583896349.git.joe@perches.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a61c388f-bb42-e6e6-7381-5e99c8dad95e@gmail.com>
Date: Wed, 11 Mar 2020 09:35:54 -0700
MIME-Version: 1.0
In-Reply-To: <e78fb08d1dcf0d95175fc2866c344fbef2ff7065.1583896349.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/10/20 9:51 PM, Joe Perches wrote:
> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Please fix the subject to be:

net: bcmgenet: Use fallthrough;

to match commits done to this file.
-- 
Florian


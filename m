Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD68C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F1D20848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgCIOEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:04:49 -0400
Received: from mail.manjaro.org ([176.9.38.148]:60532 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCIOEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:04:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 37BE937022D3;
        Mon,  9 Mar 2020 15:04:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l9v5AQ1gEZNV; Mon,  9 Mar 2020 15:04:45 +0100 (CET)
Subject: Re: [RFC PATCH 0/1] Add generic inverted led triggers
To:     Pavel Machek <pavel@ucw.cz>, Tobias Schramm <t.schramm@manjaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200308142722.1199260-1-t.schramm@manjaro.org>
 <20200308212649.GA31247@amd>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <10a57ef4-e8a3-2aea-ee28-2c3bb187c17a@manjaro.org>
Date:   Mon, 9 Mar 2020 15:05:49 +0100
MIME-Version: 1.0
In-Reply-To: <20200308212649.GA31247@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

thanks for the feedback.

> Not a big fan (sorry).
> 
> We have already _way_ too many triggers, we don't want to have twice
> that much.

True. Doubling the amount of triggers is probably not a good idea.

> 
> Better implementation might be to have a trigger attribute doing the
> inverting.

I agree. Especially since Jacek pointed out that some triggers do that
already.

> 
> Inverting really does not work with all the triggers; numlock-inverted
> will not get too many
> users. always-on-inverted... blink-inverted.... I guess it does make
> sense for disk activity (but be warned disk can be continuously active
> for quite a while).
> 
> What triggers do you think make sense inverted?

I think all kinds of activity indicators (disk-activity, mmc, usb, ide,
nand, cpu, network, etc.) make sense. Guess I'll add a flags field to
the led_trigger struct and have an invertible flag that specifies
whether a trigger should be invertible or not.


Thanks again,

Tobias

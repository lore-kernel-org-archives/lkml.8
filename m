Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CE820672
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391338AbgFYWEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 18:04:04 -0400
Received: from mail.itouring.de ([188.40.134.68]:37352 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390431AbgFYWEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 18:04:02 -0400
Received: from tux.applied-asynchrony.com (p5ddd79e0.dip0.t-ipconnect.de [93.221.121.224])
        by mail.itouring.de (Postfix) with ESMTPSA id 15B114160251;
        Fri, 26 Jun 2020 00:04:01 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id BFD36F01605;
        Fri, 26 Jun 2020 00:03:52 +0200 (CEST)
Subject: Re: [PATCH] sched/cfs: change initial value of runnable_avg
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200624154422.29166-1-vincent.guittot@linaro.org>
 <7f2b3135-328b-a510-ce23-49e3f5c20965@applied-asynchrony.com>
 <CAKfTPtD4+gUkz7Z2o9yyuK09M0bmP=Y+pZTYswNt=yVC4WVkyQ@mail.gmail.com>
 <c4574b9e-852d-8f04-91cb-0fbae9f89833@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <fdc863f1-5e59-6d8a-7eff-7f4d1108f78e@applied-asynchrony.com>
Date:   Fri, 26 Jun 2020 00:03:52 +0200
MIME-Version: 1.0
In-Reply-To: <c4574b9e-852d-8f04-91cb-0fbae9f89833@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 12:42, Holger Hoffstätte wrote:
<loadavg weirdness>

Nevermind, it turned out to be something else after all.
I'm not entirely sure *what* exactly yet, but for some reason my loadavg
is high again for no good reason.
Sorry for the false alarm.

-h

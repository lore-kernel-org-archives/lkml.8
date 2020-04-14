Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92956C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6C82075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391141AbgDNP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:59:27 -0400
Received: from foss.arm.com ([217.140.110.172]:58974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbgDNP7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:59:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6163F31B;
        Tue, 14 Apr 2020 08:59:18 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFD073F6C4;
        Tue, 14 Apr 2020 08:59:17 -0700 (PDT)
Subject: Re: stop messing with set_fs in arm_sdei
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200414142302.448447-1-hch@lst.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <cc0b5d01-bd19-3437-a76e-2d1daa86f9a4@arm.com>
Date:   Tue, 14 Apr 2020 16:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200414142302.448447-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 14/04/2020 15:23, Christoph Hellwig wrote:
> can you take a look at this series?  I've been trying to figure out
> what the set_fs in arm_sdei is good for, and could not find any
> good reason.  But I don't have any hardware implementing this interface,
> so the changes are entirely untested.

Its a firmware thing, think of it as a firmware assisted software NMI.

The arch code save/restores set_fs() because the entry code does that when taking an
exception from EL1. SDEI does the same because it doesn't come via the same entry code. It
does it in C because that C is always run before the handler, something that isn't true
for the regular assembly version.

The regular entry code does this because any exception may have interrupted code that had
addr_limit set to something else:
https://bugs.chromium.org/p/project-zero/issues/detail?id=822

and the patch that fixed it: commit e19a6ee2460b "arm64: kernel: Save and restore UAO and
addr_limit on exception entry"


Thanks,

James

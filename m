Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21080C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0341920714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXNNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:13:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgGXNNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:13:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 679B3AC46;
        Fri, 24 Jul 2020 13:13:51 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] xen/balloon: make the balloon wait interruptible
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20200724124241.48208-1-roger.pau@citrix.com>
 <20200724124241.48208-3-roger.pau@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <57d403c1-5df4-d4cf-3faa-2aae2ba1faa1@suse.com>
Date:   Fri, 24 Jul 2020 15:13:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724124241.48208-3-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.20 14:42, Roger Pau Monne wrote:
> So it can be killed, or else processes can get hung indefinitely
> waiting for balloon pages.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


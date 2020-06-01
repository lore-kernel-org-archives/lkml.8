Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E603C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725EF206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgFAIz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:55:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:57220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFAIz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:55:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB755AC51;
        Mon,  1 Jun 2020 08:55:27 +0000 (UTC)
Subject: Re: 5.7-rc0: kswapd eats cpu during a disk test?!
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Cc:     mhocko@suse.cz, "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20200531103431.GA28429@amd>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e3afe444-4541-b420-0888-575cae8aa46d@suse.cz>
Date:   Mon, 1 Jun 2020 10:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200531103431.GA28429@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC linux-mm

On 5/31/20 12:34 PM, Pavel Machek wrote:
> Hi!
> 
> This is simple cat /dev/sda > /dev/zero... on thinkpad x60 (x86-32),
> with spinning rust.
> 
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+  COMMAND
>    1000 root      20   0       0      0      0 R  53.3  0.0  57:34.93  kswapd0
>   27897 root      20   0    6976    580    536 R  44.5  0.0   1:44.53  cat
> 
> It keeps both CPUs busy... and I don't think that's right.

Does an older kernel behave differently here?

Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E06C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3E320771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hB28V+eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgC3Xq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:46:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgC3Xq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vUuaS2x8JQRuzncteKDDiiu81wU7NBj9Y4r1asfsrBE=; b=hB28V+ehoXaCUU+9lmVuCckb+y
        nobjcXFQg7hwPHve5iFTUOCYx/KkAES+Vo2dOIggBTRYQ1qL7DM/B8ZZJV4xE651fYpMfUkxZqT3F
        kE3cfa22BFsTy+a0Ibpy66CsmdP/ViKtI6SQIJGHnW0bHRuZxTaAg3Gn5QwmcAaMw9xefW4C05p+j
        RDjhCMQ7Qr2Wj8w59WpunP9DPex/G6rvBtBtbN/MUZ7LZ1vbq+QBGFpFwvFayyWDriA9ks1E3yQ/v
        oGwY8n6H7TKUtTAlvFalH2G7jEayWCN1mSHqkMCaDuGgIN91BfHEUdJNzYOuSs43M4COu4IWWrvYx
        AUhJUBrQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ46q-0004vd-Lp; Mon, 30 Mar 2020 23:46:24 +0000
Subject: Re: [GIT] Networking
To:     Paul Bolle <pebolle@tiscali.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
References: <20200328.183923.1567579026552407300.davem@davemloft.net>
 <CAHk-=wgoySgT5q9L5E-Bwm_Lsn3w-bzL2SBji51WF8z4bk4SEQ@mail.gmail.com>
 <20200329.155232.1256733901524676876.davem@davemloft.net>
 <CAHk-=wjDZTfj3wYm+HKd2tfT8j_unQwhP-t3-91Z-8qqMS=ceQ@mail.gmail.com>
 <1a57d88410e8354d083ad31e956bb03d1a8e3c0b.camel@tiscali.nl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2116db06-272a-de6d-1484-b9900b018683@infradead.org>
Date:   Mon, 30 Mar 2020 16:46:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1a57d88410e8354d083ad31e956bb03d1a8e3c0b.camel@tiscali.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/20 2:18 PM, Paul Bolle wrote:
> [Added Johannes.]
> 
> Linus Torvalds schreef op zo 29-03-2020 om 15:54 [-0700]:
>> On Sun, Mar 29, 2020 at 3:52 PM David Miller <davem@davemloft.net> wrote:
>>> Meanwhile, we have a wireless regression, and I'll get the fix for
>>> that to you by the end of today.
>>
>> Oops. This came in just after I posted the 5.6 release announcement
>> after having said that there didn't seem to be any reason to delay.
> 
> If this email gets through this should be about "mac80211: fix authentication
> with iwlwifi/mvm". Is that right?

Yes.

-- 
~Randy


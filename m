Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5742C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBA62072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590068193;
	bh=k1U9skoq/IsxYcIdWWwltNtKISxIBRqA2/fMuQ1l6/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pjDkFwZTwW9+lyEup8lsKpLnHEhWw9JaSke4K29ca75tHzGG7ezdAfIhhzv9jopW3
	 QadTGEQCkr0sBhION4tPnqdRgj4fllX4l6PFn3BdgPIw37I2PQJjHLtwd5zI2GkFuj
	 Ig+geNv3kR6nJsZYcxHTPjdBAfxzd/j/kgXDoqAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEUNgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgEUNgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:36:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B1720721;
        Thu, 21 May 2020 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590068192;
        bh=k1U9skoq/IsxYcIdWWwltNtKISxIBRqA2/fMuQ1l6/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiiMcKpG6X/JtSWMRjsdR4p6LuRA638LAeg+KATziaRhN/rYR30X+H1cRyg2j6sNR
         7Un+7kyMPRvtO7ty1OSPtx03+GEGN+hUfOWrR7Xt8mWojHmBThZGBavKtafysKxzk4
         xlvFQK7Fl0BjhVJGb4cXmwQ0GdzDlyuU512y8Dvk=
Date:   Thu, 21 May 2020 14:36:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, clang-built-linux@googlegroups.com,
        bp@alien8.de
Subject: Re: [PATCH -tip v2 00/11] Fix KCSAN for new ONCE (require Clang 11)
Message-ID: <20200521133626.GD6608@willie-the-truck>
References: <20200521110854.114437-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521110854.114437-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 01:08:43PM +0200, Marco Elver wrote:
> This patch series is the conclusion to [1], where we determined that due
> to various interactions with no_sanitize attributes and the new
> {READ,WRITE}_ONCE(), KCSAN will require Clang 11 or later. Other
> sanitizers are largely untouched, and only KCSAN now has a hard
> dependency on Clang 11. To test, a recent Clang development version will
> suffice [2]. While a little inconvenient for now, it is hoped that in
> future we may be able to fix GCC and re-enable GCC support.
> 
> The patch "kcsan: Restrict supported compilers" contains a detailed list
> of requirements that led to this decision.
> 
> Most of the patches are related to KCSAN, however, the first patch also
> includes an UBSAN related fix and is a dependency for the remaining
> ones. The last 2 patches clean up the attributes by moving them to the
> right place, and fix KASAN's way of defining __no_kasan_or_inline,
> making it consistent with KCSAN.
> 
> The series has been tested by running kcsan-test several times and
> completed successfully.

I've left a few minor comments, but the only one that probably needs a bit
of thought is using data_race() with const non-scalar expressions, since I
think that's now prohibited by these changes. We don't have too many
data_race() users yet, so probably not a big deal, but worth bearing in
mind.

Other than that,

Acked-by: Will Deacon <will@kernel.org>

Thanks!

Will

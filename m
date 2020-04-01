Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F3DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABA720787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585737146;
	bh=K/TshmhsmGDHbzjcDThyyiOGSmSiSQp27QucTMY8BIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ANgS7OfEwI+EIuNIe4rGjZTSrjvrI1CiE1D1vJTYtr+kZSNzr0OEjeORxYdHTDaQ
	 mhuTebkzyPKTLKUVhpjGoJ3ESxaLPFKeTw8SGDY6B0FvfuJri3ohVElI96KPFNAsuG
	 b2S6RnI8Q+u8svh24kwDIsLg8NHea5nFygxFa4Gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbgDAKcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgDAKcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:32:25 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAEA20772;
        Wed,  1 Apr 2020 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585737144;
        bh=K/TshmhsmGDHbzjcDThyyiOGSmSiSQp27QucTMY8BIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4j28szCoZ1Gk5s7g4wB+lr9JxObXFo2syF/KoxhFHcgpulFBd+DYDzvA2IIoeh0t
         3R4c8X15oqTdxNio9/IYshIuNOAsFE3vx6UwOv0V/O9EdCdTYTHB6O77yW+bIqCRW3
         HJliqYn6wyYaAkwI/PWMDf+N3vwgqcxFuSUR31as=
Date:   Wed, 1 Apr 2020 11:32:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Subject: Re: [PATCH] checkpatch: Warn about data_race() without comment
Message-ID: <20200401103219.GB17575@willie-the-truck>
References: <20200401101714.44781-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401101714.44781-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 12:17:14PM +0200, Marco Elver wrote:
> Warn about applications of data_race() without a comment, to encourage
> documenting the reasoning behind why it was deemed safe.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  scripts/checkpatch.pl | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a63380c6b0d2..48bb9508e300 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5833,6 +5833,14 @@ sub process {
>  			}
>  		}
>  
> +# check for data_race without a comment.
> +		if ($line =~ /\bdata_race\s*\(/) {
> +			if (!ctx_has_comment($first_line, $linenr)) {
> +				WARN("DATA_RACE",
> +				     "data_race without comment\n" . $herecurr);
> +			}
> +		}
> +

Thanks, looks sane to me:

Acked-by: Will Deacon <will@kernel.org>

Although I suppose I now need to add some comments to my list stuff. I
didn't think that through, did I? ;)

Will

Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01090C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67EA206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WVZsbjym";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="YpLyGfzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgA2RLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:11:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52474 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgA2RLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:11:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FBA4B7BF5;
        Wed, 29 Jan 2020 12:11:17 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=yhpprhRgYxzLs+VKpBm5f0Z6eus=; b=WVZsbj
        ymcLJjf3ZB9GMSGBhB6rfJdNgHo71cWLjttm4HZ6t/V93kD+p3aAqKP+H27y06h8
        mbDK3a+/p52ByA3lOwkN0x6PEx8TnAv3TTgMK3NFKfC2chAv7LFW89Lnjn2FTj4V
        Yna4h5LICSO4yyy6QhLo9jp/Ur9chpID+cQT0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48010B7BF4;
        Wed, 29 Jan 2020 12:11:17 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=9iQOHCEK505gx5TM5IZMQO697Nr7FynB48JFpUkroME=; b=YpLyGfzmEhwRoF8A3FbVzcF1Ft0fW4SDDazy4+2dtpaxEaFHx8Qm30GEnVpiOqfVkDJWH2hKQSbAxQ3hKT3chHLKOBiHpap4yfKEhGALHeWen54EyBmCJw1242ODfSoqRbbygUyCG/K6nhJ1ln6sZV+NQjIemzvTpTKcaTe+8cY=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 36C85B7BF3;
        Wed, 29 Jan 2020 12:11:14 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 608852DA013B;
        Wed, 29 Jan 2020 12:11:12 -0500 (EST)
Date:   Wed, 29 Jan 2020 12:11:12 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Quentin Perret <qperret@google.com>
cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, maennich@google.com,
        kernel-team@android.com
Subject: Re: [PATCH] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYMS
In-Reply-To: <20200129150612.19200-1-qperret@google.com>
Message-ID: <nycvar.YSQ.7.76.2001291152540.1655@knanqh.ubzr>
References: <20200129150612.19200-1-qperret@google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 5AC4AC00-42BA-11EA-95E9-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020, Quentin Perret wrote:

> CONFIG_TRIM_UNUSED_KSYMS currently removes all unused exported symbols
> from ksymtab. This works really well when using in-tree drivers, but
> cannot be used in its current form if some of them are out-of-tree.
> 
> Indeed, even if the list of symbols required by out-of-tree drivers is
> known at compile time, the only solution today to guarantee these don't
> get trimmed is to set CONFIG_TRIM_UNUSED_KSYMS=n. This not only wastes
> space, but also makes it difficult to control the ABI usable by vendor
> modules in distribution kernels such as Android. Being able to control
> the kernel ABI surface is particularly useful to ship a unique Generic
> Kernel Image (GKI) for all vendors.
> 
> As such, attempt to improve the situation by enabling users to specify a
> symbol 'whitelist' at compile time. Any symbol specified in this
> whitelist will be kept exported when CONFIG_TRIM_UNUSED_KSYMS is set,
> even if it has no in-tree user. The whitelist is defined as a simple
> text file, listing symbols, one per line.

The idea is sound to me. But...

> diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> index a904bf1f5e67..1a6f7f377230 100755
> --- a/scripts/adjust_autoksyms.sh
> +++ b/scripts/adjust_autoksyms.sh
> @@ -48,6 +48,7 @@ cat > "$new_ksyms_file" << EOT
>  EOT
>  sed 's/ko$/mod/' modules.order |
>  xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
> +cat - $CONFIG_UNUSED_KSYMS_WHITELIST |

This is a nice trick, however it'll fail if the file path contains 
spaces or other shell special characters. You could try something like 
this:

[ -z "$CONFIG_UNUSED_KSYMS_WHITELIST" ] \
	&& whitelist= \
	|| whitelist="\"$CONFIG_UNUSED_KSYMS_WHITELIST\""

And then...

  eval cat - $whitelist | ...

This way, if $CONFIG_UNUSED_KSYMS_WHITELIST is non empty, it'll get 
quoted.


Nicolas

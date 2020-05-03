Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E90C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871402073E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Dq4xmUY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgECNEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgECNEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:04:06 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD8EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 06:04:05 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id z1so167662qva.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lgDLstrxQHhDxzWYd9/HS8YbBd/gpsI1gpTdprUS3Jg=;
        b=Dq4xmUY0lO9O9aVqYMQW5AsSTJeAnnfNOWuxdYL/g2r28y6kJLGyYc1PX7+z0JukAq
         wyAcVZSwZkjc8VRCxLRJn26bGkxezGegSNuTNUn6w67H5qd3dkSA77rAL50b9yC404V4
         st+f6Z9L6/MaGb5U7JV0MHQEbLyEFw68ozLmhtw0LfDgKYWFJEl+/M0sjOi+SGMPNiuJ
         1PYT0sh2oERfJPQEuk2g3WZDGC2RoC37Z5PSNIZz7FSpBei+eYjhf2wy61mmLeqyF9AD
         ir673fIn5utfDxhEE2iD26R3vkKcGUE67v1Tjt05ErNGuWkt57eXT7Ah9rfKVFuIQ2A/
         96QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lgDLstrxQHhDxzWYd9/HS8YbBd/gpsI1gpTdprUS3Jg=;
        b=hE1fAgeRYYPiCuWN1snWNPW0oIL8S3/mLyr5r4F3rr0rMFxXbmBlqpfkOO3sJmeqz8
         FxOKiIaKB/6KTz5YsbxjgU0XTx3fXkuu+YWCNqtLgssSlRYbrzjrUsp4UCcthpIbTi+9
         2TI3wObssT6Q3hkT9i27xExxbIC1+XJfYmUrXTzZLA+mGSwTaffLYTHywLcEOuPQC1hm
         fvj+vfdRHonk91pNviDUeMI7LKEPkOlG0xG2kgLlZfw5zCdkyE5p50v4IbHAvFHN7VKO
         c2HBm7oMDxoIMKacCiEj5u+FNSkCzgoyX+syFEP7cxTvgxozLDaQmdjmSopNUweuneJm
         AACg==
X-Gm-Message-State: AGi0PuZK0vjXv7yLq/JtJpL66CbInzbYu0wL8PPF4UQyWdpbLVYHwWPL
        ZaRopsht5jjwhC0Unqxenlz91A==
X-Google-Smtp-Source: APiQypLj7z+/+acBcByAY2J0cQ1YHYr/bMN4osB4axBDCIP2jxqqkeKhAAc+D3was7U+m5tQweO+wg==
X-Received: by 2002:a0c:e992:: with SMTP id z18mr12711287qvn.25.1588511044636;
        Sun, 03 May 2020 06:04:04 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i5sm7689441qtw.97.2020.05.03.06.04.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2020 06:04:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200429112014.GN21900@8bytes.org>
Date:   Sun, 3 May 2020 09:04:03 -0400
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E351FE35-3130-48B0-90ED-BC55469C73F7@lca.pw>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
 <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
 <20200429112014.GN21900@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 29, 2020, at 7:20 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> On Mon, Apr 20, 2020 at 09:26:12AM -0400, Qian Cai wrote:
>> No dice. There could be some other races. For example,
>=20
> Can you please test this branch:
>=20
> 	=
https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=3Dam=
d-iommu-fixes
>=20
> It has the previous fix in it and a couple more to make sure the
> device-table is updated and flushed before increase_address_space()
> updates domain->pt_root.

I believe this closed the existing races as it had survived for many =
days. Great work!=

Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A17EC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2780620674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4uRAsAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCIJOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:14:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40963 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgCIJOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:14:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id v4so10020893wrs.8;
        Mon, 09 Mar 2020 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gNq30HQChE9APu7rDl4pmQLY8Q3W3zNkiiSWKX0ep0=;
        b=U4uRAsAjdMngVnLEmh34E0iv2yJqOlW5NiNoVvTjz44lCejcNcKMVMfpCNbiQUUYy7
         XliWqsX2LCxYaWNdYBAkUkpyWjQScBqyyA3VZumVbvC+H6OQ4FDY1jz/rIt89R6NXDet
         YXufJegSSJLYrt5KQSfXyij6OcQXC1ASqnIiO7IeJCQF7ldrN97FHCxzhdemC9MRsO82
         Gg2PLSO8c78jkUAFsW2fFIAcVHKkBukdrvs6OhfrVAno28e9ZN+60YEEbbp+z4wQewV9
         2CdcGhYQheaR6o1sgt+ppT/DTb5mErtx3Td9loUkSU/XnLhzoflcWftjUHH+oGNQ7x2l
         skWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gNq30HQChE9APu7rDl4pmQLY8Q3W3zNkiiSWKX0ep0=;
        b=ZV+zfuZBvA0WY4faCvzJdGQBamSWsXA0IhUwpMNKVXNp7Z2JC2vTR3s9e8uQRK7PsB
         WvCEbRLbTzCzpxatZVT9Js39DX3z9gA6eMYpCOckJI5J/TY4/fA0ZMJcXSrZDmvRBvUj
         v0jVlggPjdNHmIaqTH5vYi3uzn6DNvN7po6Ui+8MyPE+ayXyDkFPMuSChgQNJRLJp2eh
         AOOMMDe1ukUmok190rOxISklEr6z5GEkhEfcFPbC0vfTR0MBUD8mG+tPqDVA/NCMZ6dW
         vj1NBEMU61aBdcqHZRHUvBgj5fcV4RkyUVKBNbKDtWI5+2F6npQ0zS6djOxnCkhkRQAZ
         vB8Q==
X-Gm-Message-State: ANhLgQ1uz2SGLgZhWGB80gmrcAk1BoL8SdBr5F20M2jPzXjZHoltYOYm
        oy1AG73VippSpCQeZ7w3WSL6gjQLV47peu0pm7w=
X-Google-Smtp-Source: ADFU+vvtRbr9gutjZh50RFHVyKpzyR1qX3DOkxmPTOL1TiGPSx1ZeJI8+FjWgQsr7aFhh3RypL+b7KzXlJL2JASZOCo=
X-Received: by 2002:a5d:6208:: with SMTP id y8mr12886083wru.64.1583745278410;
 Mon, 09 Mar 2020 02:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200307060808.6nfyqnp2woq7d3cv@kili.mountain>
In-Reply-To: <20200307060808.6nfyqnp2woq7d3cv@kili.mountain>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Mon, 9 Mar 2020 09:14:27 +0000
Message-ID: <CAK+_RLm9=DER3fM-HwvM14CEzq8eZCwcTZyoA6tsYdhe1J03sA@mail.gmail.com>
Subject: Re: [PATCH] bfs: prevent underflow in bfs_find_entry()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

On Sat, 7 Mar 2020 at 06:08, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> -       int namelen = child->len;
> +       unsigned int namelen = child->len;

Thank you, that is sensible, but have you actually verified that
attempting a lookup of a filename longer than 2.2 billion bytes causes
a problem? If that's the case, then your patch should be considered.
If not, it would seem to be a waste of time to worry about something
that cannot ever happen.

Kind regards,
Tigran

Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4241FC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD872070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqHzEm5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBQNQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:16:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgBQNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:16:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so19652387wrx.11;
        Mon, 17 Feb 2020 05:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=p/uQQdbP6CtQI5bxDvGVhaC/f+9PVyfSbatM3OlAi4s=;
        b=lqHzEm5UNtGWjo21PqgaH03h2WQqDhZVrATmmQneQSSxw0OAWr5pYizoWChwVr0djZ
         9KUFAShTLryHyD5zqfG4hJTz/cAqtCvOLHIhJvr3Q7KVW+EurO+Yi4kEjjAuog8RigGO
         DGvb3aibmZxA4agX8sEpSAcwhhczpYYzAiR20y1JYwfzl9KIMKskURQ3FGYPKEQTkJRN
         mfhY785IoICmCuxwQaqqz6Q0gZUJZCgv6fJpJiAGE/RSng4jBWiQ9BLt3pjbDIFx1u9t
         qvzerbnGe3rAk6Qyphb33szJbzvsZVEzT4Fc1dGLbCu58TTXyOxm6I3WzYZ71ZK4MutK
         tjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=p/uQQdbP6CtQI5bxDvGVhaC/f+9PVyfSbatM3OlAi4s=;
        b=tNk2TjY3qGmQIOCldg8XLmO0mfJL8wLH2efnz7P2nDjtOxte6FGhAO70Qh2hpxJ2rG
         R1tB/QOeTeivpH50IPfu0jYBab4S2TPIJtNi4ikgjAI03H2XU+HSupNVGJWkWofK4qnU
         7Gti1CBc+dvK5dMt6BjlN2HPxltBU8P3g8G4Xe7YCw89oGBohromu89S9nsugjEKnOry
         sjOnaTPbTU4eat1lPNg4XyPgNC013zvWkzQBBJabPz3xJ7a1cjCSL0sxtHuDBFDDrA4j
         tHxYAOqAiJkZm6of5qEUd9trWHXo3Z2cJYUruLCCxLBemJGiCoAYuv8HwP/VIPCObwA6
         qE9g==
X-Gm-Message-State: APjAAAVLJG4b99lI7dF4ODaTFjy16sZnHKgcLH0HPRNpULNvPaHYD4xi
        Rpy8QS7jJQGK7mxdhQK72HFzd5sHN1E=
X-Google-Smtp-Source: APXvYqxl068Wx/x2bBMrsu8QHOx94CFshQcGiFI0JuLpMh4rhyh0RoBdBOR0XjR0R0lIfWKRPKlflA==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr21948552wrs.420.1581945400649;
        Mon, 17 Feb 2020 05:16:40 -0800 (PST)
Received: from felia ([2001:16b8:3888:da00:b474:2167:8661:27cf])
        by smtp.gmail.com with ESMTPSA id n1sm999072wrw.52.2020.02.17.05.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:16:40 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 17 Feb 2020 14:16:38 +0100 (CET)
X-X-Sender: lukas@felia
To:     Christoph Hellwig <hch@lst.de>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Anatoly Pugachev <matorola@gmail.com>, Pat Gefre <pfg@sgi.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty/serial: cleanup after ioc*_serial driver removal
In-Reply-To: <20200217130828.GB26781@lst.de>
Message-ID: <alpine.DEB.2.21.2002171409410.14734@felia>
References: <20200217081558.10266-1-lukas.bulwahn@gmail.com> <CADxRZqwGBi=4A224mG0cPgONdNitnvi3LFD_KQckxdYSXzgBGg@mail.gmail.com> <alpine.DEB.2.21.2002170950390.11007@felia> <20200217130828.GB26781@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Feb 2020, Christoph Hellwig wrote:

> On Mon, Feb 17, 2020 at 10:09:45AM +0100, Lukas Bulwahn wrote:
> > The description is about situations on very outdated kernel versions, so 
> > the whole page needs a general update.
> 
> While the file doesn't seem all that useful, I think removing or updating
> it should probably be a separate patch.
> 
Okay, I will send a v2 where I keep the documentation and I will add a
maintainers entry for Documentation/ia64/ to IA64 (Itanium) PLATFORM.

Lukas


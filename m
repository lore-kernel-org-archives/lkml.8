Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9EAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BC422CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB7I0ztJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgHEGz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEGz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:55:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF01C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 23:55:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l60so3960589pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SGZKUpYTKCkpMjR2/gp6H6g/7u9i9ZZGE+6qybYiQ1Y=;
        b=eB7I0ztJTU4WSthYXqaqoUu5nSugYMxc2h5yrlbERDylgNa5sZlC76hDkZJW/uGdnY
         ryKSBxW9gyHVLeTlXc6NsDiakiPlYlrOyMvJ/xlp1jS23dc0hXzSpa4Cl8FGA2UIilYA
         xGMU+MW5UDmVHJoqO/4M1gy3YcmzlczR8Qs7pwBwCQYHulXFSBfKNUF6DAjG7tHwurKS
         7hWQMmdU4QDHD8vWyntNOXjcA3mFqaj6QqyYjBEkYf1TZi4lLIy+F25pU0WA1Rj6B2y7
         ueSqb9UzN5PuY4e2y/IURP+J0HzudC0TfY1mYMtZYIEsE+gjxsAiOLOeySmE5XCqXHBz
         MfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGZKUpYTKCkpMjR2/gp6H6g/7u9i9ZZGE+6qybYiQ1Y=;
        b=QSFMR4+nG4LtW0F8NDTMFeQTqauvu74OhoJsyzF9RdWuDU9wyRqZQmjsQFhdfhY/36
         y4z6tYMqG2M+eRkCSZlxzMVsv4cQ17RBE1NneE/TzY/d5C4m84naxVxFZ0FtR+PRw7Iz
         oD6tBG5LOo0Rk0UQN7ij+h+pZYVu0eAzeO3JGrNyoRedqvNpiqDqDSvH6zGCMvRusmdn
         X7Ary1Cb9HapJCpr9U6BRKIFWU1deCl6ZVUBm+Hh3PgzFmBshQnE3NEzkFLpwnxDVRLE
         s46HX3cb5ar/vhx1cN1qn+zNBj/RC5c4W1/b7nqnrlBWIEeuMj7GKOE8ABdFUHM1nozO
         b9jg==
X-Gm-Message-State: AOAM533dCsR9tKKLW0xGlRa4AZNkNGl961Nq8+/LlA26cWKy3Fu+UNoi
        HgBb/K7eVPp59s3ltfaGKEA=
X-Google-Smtp-Source: ABdhPJx4V/D/s9pzIYwlx+8snhleVdhwnfP6tP4uC6/N2c5q73hqwxsDv7A3bUhT6kOfk3YclbwQTg==
X-Received: by 2002:a17:90a:c58b:: with SMTP id l11mr1847841pjt.195.1596610526653;
        Tue, 04 Aug 2020 23:55:26 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id h5sm1835143pfq.146.2020.08.04.23.55.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 23:55:26 -0700 (PDT)
Date:   Tue, 4 Aug 2020 23:55:12 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ASoC: fsl_sai: Replace synchronous check with
 fsl_sai_dir_is_synced
Message-ID: <20200805065511.GA1131@Asurada-Nvidia>
References: <20200805063413.4610-1-shengjiu.wang@nxp.com>
 <20200805063413.4610-4-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805063413.4610-4-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 02:34:13PM +0800, Shengjiu Wang wrote:
> As new function fsl_sai_dir_is_synced is included for checking if
> stream is synced by the opposite stream, then replace the existing
> synchronous checking with this new function.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Nice, thanks!

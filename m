Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E861C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8B521582
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKcX83qN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIGGeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgIGGeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:34:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A0FC061573;
        Sun,  6 Sep 2020 23:34:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 7so7551993pgm.11;
        Sun, 06 Sep 2020 23:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m15jCTtsBAUKP+0jfB9in9HIjBdPjBE4Y+TgmZ5/xE0=;
        b=oKcX83qNAmH/enHKgQVFuUZrgn1v592Ii5llp56wrH1uuq47AuZF7tgvVTEacw8m5X
         67Ha0oF50dm2WcuelnBDh7hoqksWVFv232g7FbvwYXSjOqnAxRGNrnBqxkuCn41Jk907
         KGmT2IDHdkSTpTO7vySyW4tq1LLXCMObaVHpaPcUkV95g6ScpC8AuUk3d3DHA0Vfp/nj
         WfGbFYRiW4klopM/ON/sZuPQKlaNz/uRCshXvOq5aat/oTI4z864Ux2Xa8tGvloE2UiV
         drbQdLjifGkxsl/NBlYH1b8VSLUrm4bWyRrzVYrr8h0Z2RPhc0Wgw71cWYavkTCCdtzn
         3BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m15jCTtsBAUKP+0jfB9in9HIjBdPjBE4Y+TgmZ5/xE0=;
        b=HVn78obfIpIYRQsjEAxdRu7dTIYvTu995NHdXq/xVxOl49X9aUUvr4fZyLx+HD7ZUm
         4K9axayh6a0I54uZnqZS1FUQARZ2QLk/VSee6mdIiAriUX5jz8I90N+1kh04N7TGtkh3
         Idg57JtfB1YKclXDvcI9Z9VzzZVjhn3lp3n1szr4fwfucVKZDXW33GMI0h8qktpHswkI
         Nh86bcGPKKyxGxnzn9RubwUpIljpP7t5Yr9gaoT4dK0d5JNMCH7+rjzdJaMgLjheHTaR
         Y/S2aQlploQLRK5ZOw87h8GoJgoSvefcUWJnGAyBoPww15AvwaQitBIlRVbfp6Zmpguq
         a/4Q==
X-Gm-Message-State: AOAM531MWw8ZY2n2h8FqGQZocALg+H/+2/eHASgb4CgirNDvpAekWF9Z
        uDXOtxLAWeGJkCMHHWLdB5A=
X-Google-Smtp-Source: ABdhPJw6ZH79o8HU3/QSSp52qMLeXwXaUJN0ob6XhOQCKSaHK7Tzit4rT2kSbg628qUever7ECTm0A==
X-Received: by 2002:a62:8607:0:b029:13c:1611:6593 with SMTP id x7-20020a6286070000b029013c16116593mr16912878pfd.16.1599460440268;
        Sun, 06 Sep 2020 23:34:00 -0700 (PDT)
Received: from gmail.com ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id q82sm14767933pfc.139.2020.09.06.23.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 23:33:59 -0700 (PDT)
Date:   Mon, 7 Sep 2020 12:01:53 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1 0/2] video: fbdev: radeonfb: PCI PM framework upgrade
 and fix-ups.
Message-ID: <20200907063153.GA29062@gmail.com>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200806072658.592444-1-vaibhavgupta40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please review this patch-series.

Thank you
Vaibhav Gupta

Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C94C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4773620810
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uzye1Hii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgFQACs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFQACs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:02:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE5C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:02:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d8so74501plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oe/hKAKHGvJszycxiAbC2N5QfwK/kv0uW4M610gYZnY=;
        b=Uzye1Hii/AU8ot5ff4TsthmYVWhTUyRMrsmmfyHoIJqYq0Eczq1dwhp+mbdXjzxeAk
         9wtUHLgg37QXJIUyFQ6rDtjQp3FQFt9exXKj6glBGuADuVrm6eo0dkXUYsQLogY6rCI9
         BpLcmQTqsen/Cx1v4BpvB1mjEzFdSmlc8bDSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oe/hKAKHGvJszycxiAbC2N5QfwK/kv0uW4M610gYZnY=;
        b=Gm+5gXIeXtbYMWsBPMAnBaZi/J5b+Sdbvnts1IGTw7XQAgAypz9CqVFNnJOKmjlp3E
         6+4SdfCs0CCmbFKOfb1efJ/ccL+/0hgGsfUw7lTXPO0cJS/NC4q5BKj4ftmtji4VL6nk
         9l76fQKDYtMF1J+HvCscA/PFbmD5G9kI4G1ZzuI6L3RhH+85nlSjXzAbU9Z0A9sPiQpA
         OCkPUs2xidmO9fLcQn18fcl1vx/hmgSQpBPGYK5nz8lbcWIsNHkn9DZFVjnaOVY9qLfW
         PXerSwtIi2MusILdPj7/zWd6DCb5e1NbD5D3WZqXiTWlkSB8Q/0D4kTC64oyBHnWjYmh
         VPpQ==
X-Gm-Message-State: AOAM53043aAA6aiXrux3U67p+nP3AoAr4Y2owUpok45Ce3V9C0SMRPg0
        yY3nl8VRTsMliSDDh7FPMVVU3Q==
X-Google-Smtp-Source: ABdhPJxoKbB2AxNcWqAGD8BdmcD9iQ3Qib8cSe2Dw81g0u/XxRdehdq7O3qmk9pRWtrwZeHldhqg5g==
X-Received: by 2002:a17:90a:be09:: with SMTP id a9mr4981100pjs.43.1592352166752;
        Tue, 16 Jun 2020 17:02:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 10sm17861488pfn.6.2020.06.16.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 17:02:45 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:02:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006161701.685284F@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CABVgOSkrKHs_uWLZ++_fBC_mfe3RgDxmCvnkcyn1P_wjXTV9Og@mail.gmail.com>
 <CY4PR13MB11756803217A9D20456E826FFD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g458XTDftQAOm-K4Squ5-ZuZnZcFdVUG0JtUWF56cODOVg@mail.gmail.com>
 <CY4PR13MB1175CB6221D5859AAC9920C6FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB1175CB6221D5859AAC9920C6FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:37:18PM +0000, Bird, Tim wrote:
> One thing that needs to be rationalized between KUnit and selftest
> is the syntax for subtests.  KUnit follows the TAP14 spec, and starts
> subtests with indented "# Subtest: name of the child test"
> and selftests just indents the output from the child test, so it
> starts with indented "TAP version 13".  One issue I have with the
> TAP14/KUnit approach is that the output from the child is different
> depending on whether the test is called in the context of another
> test or not.

Right -- I'd *really* like the subtests to be "separable", since the
primary issue is actually that a subtest may not know it is a subtest,
and passing that knowledge in may be difficult/disruptive.

-- 
Kees Cook

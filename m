Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5602AC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E98320674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bimL89L0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgGOBXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 21:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgGOBXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:23:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B84C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:23:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m22so858447pgv.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NT375/NWnBuLf4KzmogX9uCvmnJa241H/PijGYCo0Rk=;
        b=bimL89L0BNwd4ir3o2j2V/AyCZ2jVBpqFkU8fi/kDsbmwoDWfcozJeb3xUXgm++f9+
         1U8Y1/W2AS591JgD3TETxDCp/+qzMH2RffI2AGu37PYQLqP9cI6PXEVdUuxRX36GauNw
         dKzr1hUEyzapgzl8H0hVFH+9sUvWDXwzCjRLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NT375/NWnBuLf4KzmogX9uCvmnJa241H/PijGYCo0Rk=;
        b=NWfurdZWYG74zFMDFSGosHjlJLHFzha/kwbqUmbxrHEvlZEju/h0GlX2TY85KLq27N
         V43XpRS6w7UqzgoxzqZ8DfpD4i/vkFJX96aJdUUTpb06qe1tnzhI2qXsqg9rx5jhLJCy
         YViXrDLpN+WVB8PU0KNaH5P66YE1BUhNSCT+8Q9IXEKJLOY/wdEbw4jtcrOkTGZ7Ut87
         1/Y6NEtN11WGo+20avxTPZMcayXLWX1ZRS9HMMsDMNbsq5U4iLtbqVVa241VbPbjvn1u
         8H5um30bld6yEVnrAz0RQ8lTqcauf4HU76BeBlLkQUCrrmec16lfl8t46lVUwh1SGAFt
         fXIg==
X-Gm-Message-State: AOAM532d54GHS55/brFymphmXNNjMvLYpHa65p0Zq5M2W/9bBNMyirGB
        QBt7/uWwdeq5Q9YoJyIb1ieQng==
X-Google-Smtp-Source: ABdhPJzfbFkAdUV1tVZNSCYI/nTLerjov6WaHg2IDFRE3YJozMZNUHsxrGh7aJib+qaIcupcJ1NajA==
X-Received: by 2002:a63:405:: with SMTP id 5mr5473617pge.449.1594776196084;
        Tue, 14 Jul 2020 18:23:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm306378pgf.9.2020.07.14.18.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 18:23:15 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:23:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 13/75] x86/boot/compressed/64: Rename kaslr_64.c to
 ident_map_64.c
Message-ID: <202007141823.65F31DE0@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-14-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-14-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:08:15PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The file contains only code related to identity mapped page-tables.
> Rename the file and compile it always in.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

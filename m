Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940D9C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674AC24671
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0qIGLPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBTADm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:03:42 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47061 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgBTADl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:03:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id a22so25701389oid.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHeIdmxOoP0hF/CsX1z22j/VcXTF+m2n9SPCMuF9eo0=;
        b=Q0qIGLPNuwluFhVMJjoUI0Nx6z7pyTSN7DOfAsbF6qO5OaYP+p/1yvW2zX1CgLr2HR
         K0OgeL1DtnewH8OGFkdUlXrehmNjgUiIXmJO2aiXfD6jEWvT99CQpYWm9279KjIQ4rbC
         Ya0A4bWv87EWS8lzBJ0Q7f88+9UwlAhD77pFZTnGu/UdG670VRiS2sIULtT46781IhuI
         YbiRP83N+GEklKllMDq1Vek5xCN/2MVOULroAXTqfgQk29icTjdS+Vg05p3ZdJgbNefK
         Z73ntL+t70lQkgEHoyThAMI7NElrteSsI7AX1PvyU62Z0Q5z5sqdYuGQTfs1sARnFNO2
         vIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHeIdmxOoP0hF/CsX1z22j/VcXTF+m2n9SPCMuF9eo0=;
        b=r1BjGL3ArwSFYxDqwClVqNzQ+pPT6ntctInqHzPD5FSpbmauv/lC2fZmt5bxfClLJS
         7VnBbZLkNe7XhOB5rjNiSJOobBn7A+1aZDGonCjlLcQad+6bTbkgePJPe4HdTNPLYrB4
         xdqH6V+TbeNYfHGtA3cCQc/BddAOKuP+PBZc2UXhiPYp1+Z0s6JfqBC/h36Da79ZYehZ
         f9jG33XWKCmb5HDZRF9X82dzknRV6ghUG4fbu/9mC68wc7S+DbvhYgRNtO02ai5LeDKY
         VFYCyw20sVOkYpXUs6clSMGoSA9yuPEyIDdo56MOR8goxoe8ESpsOmzhE4gXsEmytIki
         7j8A==
X-Gm-Message-State: APjAAAW+EFpVFNpvfiG2Igh0WLX5i0EcpVoP0jF5whmEPIZCP9qQt4qw
        h99j7V4SziyDYEczi+EHsw+blepP0SzD+FtAjQ+v1Q==
X-Google-Smtp-Source: APXvYqy4o4y6JMY/d+GfmgPPn6aadmNotKQEgu1SrOfear8zoHkmyiLy8ANr0b88zOSHe3kLSAM67virA8+YlW+Y1os=
X-Received: by 2002:a54:4086:: with SMTP id i6mr173786oii.65.1582157020886;
 Wed, 19 Feb 2020 16:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com> <20200211213128.73302-9-almasrymina@google.com>
In-Reply-To: <20200211213128.73302-9-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Feb 2020 16:03:29 -0800
Message-ID: <CAHS8izPfaq=rfUrQGDyOwbgZhw96Qbos9xAdJzs35KyLB_JZ-A@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 1:32 PM Mina Almasry <almasrymina@google.com> wrote:
>
> Add docs for how to use hugetlb_cgroup reservations, and their behavior.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>

Hi folks,

By my count this patch and the tests are the only patches in the
series awaiting review. Can you folks give it a look?

Thanks in advance!

Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C626C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCC72071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759759;
	bh=KeWVlqRWzEYT5ItnuvjBp5AiQ9jF8zmph9ObH2zqnaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GJKsczlmgXimBCM8KCwIuVaFyKlnFz8USVrzoe8xGKDMP/cux1RqhcxB0ncHuYcBB
	 fiCM7ldr68T4g9JX7j5MbpfdmXW1FWBLdeVk6b8smmHdepjwlCvyCxVZkJkPN3pr8v
	 cv+kdSsuF4YToVOJwVAtDLssdR6b2SrbDlxvTGgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbgDAQtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:49:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37783 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387716AbgDAQtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:49:13 -0400
Received: by mail-io1-f65.google.com with SMTP id q9so405865iod.4;
        Wed, 01 Apr 2020 09:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vep3wgwzFUUD2Ane5Zw0BHgbDzN8FPc6CtIdcK9L24o=;
        b=XZZ329JpIrrEthlDz+Ag/HVrKOq5m6X0ELOaJaSgXuqmzcT8d0GDx4v8SBmgH+E+OK
         QWVxj9QTbWGypsQMJG9JZ4lbmwGNMOD4JVtV6R211h4yiPSFGUn9LKZlY8IqbGr6YyX4
         5NVOxG0ToyCA2Jvw6+cEJjSMBschMY9q6frGoEGwtjQYK1yYshACHK6ZShB0lV0NevGq
         3NCYiiy4J1O65oD5KCkDw8EtP5z3TwUUq6xP/kOFePmmkt2noVljy5yIEbzAs/geQKhS
         UWmIQdAA95M1wqxt7onVoZbbI3jLdJoJ/NW7nyABP9i4YK0hk9TebFUSrXVWjF2RUtPp
         qz3w==
X-Gm-Message-State: ANhLgQ2yMZBNgMn4puTKkETSxVejy0va+xbq9HpyFNh2Y8codmKJ0/4q
        lMDmmQoPWT+hEl+/j8azNg==
X-Google-Smtp-Source: ADFU+vuqz2KiEC3csnkg/SrY7YEaf7PIm1n3bYX0ZwO0mroENU2d7VXxnwXl57f6i00qEGBRbYdvuA==
X-Received: by 2002:a6b:3e42:: with SMTP id l63mr21675640ioa.140.1585759752892;
        Wed, 01 Apr 2020 09:49:12 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f74sm836607ilh.77.2020.04.01.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:49:12 -0700 (PDT)
Received: (nullmailer pid 2228 invoked by uid 1000);
        Wed, 01 Apr 2020 16:49:11 -0000
Date:   Wed, 1 Apr 2020 10:49:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 02/12] MAINTAINERS: dt: update etnaviv file reference
Message-ID: <20200401164911.GA1620@bogus>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
 <62bfbba8192469976129adf24783b1534b19d6e4.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bfbba8192469976129adf24783b1534b19d6e4.1584450500.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:10:41PM +0100, Mauro Carvalho Chehab wrote:
> The etnaviv file was converted to json and renamed.
> 
> Update its reference accordingly.
> 
> Fixes: 90aeca875f8a ("dt-bindings: display: Convert etnaviv to json-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patches 2 and 3 applied.

Rob

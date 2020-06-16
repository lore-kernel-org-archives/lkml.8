Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75599C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4494F208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPoTPmVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbgFPSLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbgFPSLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:11:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DFBC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:11:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 64so9871202pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V8krypQYvLLdoGkdoWAmqL4AijiFXVU+JMq1HqUDiLE=;
        b=DPoTPmVq8LnQ8E46Fms7EJqK2SCs0dbHEwdpcZB8xUde2Ie3gU9CCHATQ+JDgkiflb
         l1mY+O3zFozAf5/wiKJIT2zuvtEsAq/ADYa/3oQKbSedxk2+P6sd1Mvc78vPLB7GiRYx
         9nHe/GW3QWOfbPS7JComESZiQ9KEtVI+AfvR4MmEVpQHpP6yR4JHh1Px8qqcA3KE7xXY
         9DqhNwLiBmoIyazx0eDxbysFSlhzWhcXXZCdLB1CJ4TIOUhFA1pjdnzmBG4oyry1XXQF
         32duI8CY14pUR61Ii310aSvAFPP1XPf71Rho0grRTe3RJIY7iCE+q27RZANAwoukgM60
         HGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V8krypQYvLLdoGkdoWAmqL4AijiFXVU+JMq1HqUDiLE=;
        b=ccV4954/IKv0E4Y8Z/rbNj/Ikr5jWmLC9crhrLA8hF0UDjhe7evI8xwbIXWqS7DBHl
         ihDDpQGrbYwqky2EHzFCg22RraKy0iGABEahWaufFXTbXNWTx0mLxFAj6uRPKWpyB6TQ
         QsN9JLv7fOfRJnZ71ME3trpYgmfcx1JhZSzPz+tKRhXpA6rZQdZmepjFD698cOnQO8Ei
         fsHY7EwmKn+U6snQv+KQhK+x9HU01T/x5h3BTj4MI58R1Va/FlI0LyOWKvAqj5JI+JHo
         uJ+ObPAiM7KTx0waZEtk/C7gi4PXty/sSv7X4hsZ81FPFZMoNT8HwwPHmXFwn2YQa9Cx
         KU/Q==
X-Gm-Message-State: AOAM531TKgQAgogHGzZlLED7usLuto7BGBAbUebOoGwNESm7WQ/Bjkjy
        TW/kh484fYrOA7ef5fvRXfc=
X-Google-Smtp-Source: ABdhPJzwhQLrWNvkHH121vPPASIn8omkp4XiIlciAzQ2Ypefq4x3InARPVnT1WT6BkeZmcYgceofuA==
X-Received: by 2002:a63:690:: with SMTP id 138mr1947500pgg.122.1592331111761;
        Tue, 16 Jun 2020 11:11:51 -0700 (PDT)
Received: from localhost (g228.115-65-196.ppp.wakwak.ne.jp. [115.65.196.228])
        by smtp.gmail.com with ESMTPSA id u128sm17377967pfu.148.2020.06.16.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:11:51 -0700 (PDT)
Date:   Wed, 17 Jun 2020 03:11:48 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH 15/25] mm/openrisc: Use mm_fault_accounting()
Message-ID: <20200616181148.GQ75760@lianli.shorne-pla.net>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-16-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615221607.7764-16-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:15:57PM -0400, Peter Xu wrote:
> Use the new mm_fault_accounting() helper for page fault accounting.
> 
> Avoid doing page fault accounting multiple times if the page fault is retried.
> Also, the perf events for page faults will be accounted too when the config has
> CONFIG_PERF_EVENTS defined.
> 
> CC: Jonas Bonn <jonas@southpole.se>
> CC: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> CC: Stafford Horne <shorne@gmail.com>
> CC: openrisc@lists.librecores.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Stafford Horne <shorne@gmail.com>

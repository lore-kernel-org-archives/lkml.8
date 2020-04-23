Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F44C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E6420857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UwWPPSqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgDWOJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726430AbgDWOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:09:49 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62872C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:09:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k12so4933749qtm.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H/+Q8e5oerF4BwNtbt1tBZt7I6E+9pXW8RRwltOsRy8=;
        b=UwWPPSqLsDLJj5kVLj5Docv2a2W96+I7Gk7WCYQNt/o/HAaM/w1cwahcvlRS1MEr/2
         zVer42Szqrqnk2Tpyk5DIcSwlSfhbeqrJKcmyxQMSMgX3cCJbAgTcgOXbRtwmqoI6K4K
         cOT9WEagDnuHBME1l7DVLk1E9el7IZaPfIQ8G4j+SEMqU+wMeIoCy49HI5wNLDD2MVR/
         rWVO+xBa8rEqljR9lTgDntsISJTYciG1SX+TUKNuz0WefwzVd9u0Y6CECyFIDo5jGNaD
         /RST2vyCE/vew8VDEjQ13Y5f5e16rN8IR5JsCs8XVTTBJUwHSyO3IYGCv7DcN9SZIHId
         5cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H/+Q8e5oerF4BwNtbt1tBZt7I6E+9pXW8RRwltOsRy8=;
        b=Z/Cyq2cQFvPySPkklGoblewwN8cdZDWwX5InG9qtg4vi3P2nHsYaxHg45E+oWA9hEr
         DH5d1LcYA3vL59mAX/ksSLXc9p5kmHe4hT0tO2IMwDvKBriJwuQqK675gyZvXj6C/rv1
         vh5dD2qhi9TSE6R9D/sL9dmZyZD6wLPrg9WJKMWIa6Lo3Gu+ZmqMMgbDOWTthcJWUi+O
         LXenjL9w+CNkeRQFetJwJKZ8RM2EzVU+FxMQRc/CmlVv3gayI14fsqGwf4Nv/jl2/T6G
         ZnNYCIVDFJepd58mVYRtndUU4XXAjiNg66CjdQJ/2bbn4eKs2VrZ9OECgTcCZhfzLNnb
         67Jg==
X-Gm-Message-State: AGi0PubUmsUXV+Hlmo0OeD4hHK1naIyX4pOtC/ApsotfrzdNDI0Ui3jR
        cyKUY7rPB4suITpX7WPfbo8cBg==
X-Google-Smtp-Source: APiQypLxPQIFwtFObavkhsPpjyOPaIMVOJv5jOmr1rDC0lxmFCb0Y9jW+6u/iBrGk86fW5P3zu9b1g==
X-Received: by 2002:aed:258a:: with SMTP id x10mr4127236qtc.51.1587650988612;
        Thu, 23 Apr 2020 07:09:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n67sm1583727qke.88.2020.04.23.07.09.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 07:09:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRcXz-0002TU-Jo; Thu, 23 Apr 2020 11:09:47 -0300
Date:   Thu, 23 Apr 2020 11:09:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/rdmavt: return proper error code
Message-ID: <20200423140947.GX26002@ziepe.ca>
References: <20200423120434.19304-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423120434.19304-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 01:04:34PM +0100, Sudip Mukherjee wrote:
> The function rvt_create_mmap_info() can return either NULL or an error
> in ERR_PTR(). Check properly for both the error type and return the
> error code accordingly.

Please fix rvt_create_mmap_info to always return ERR_PTR, never null
on failure.

Thanks,
Jason

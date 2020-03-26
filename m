Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29385C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D27206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2x1GyZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgCZTq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:46:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41565 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:46:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id f52so7242070otf.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ee5qM+UNNhRdG2dNaTXRGtyqNayzs63lsgczoaNreJM=;
        b=l2x1GyZlkZF9oRBxhEU7te49PRoz0eu4EF/59XoktRp1nrCsRNCzbM0Lva5uP/k77G
         WC9rZMflq0KZduqjqjq8SA6Mt6IlMZCkQ7x/RLm8/SXvM+++pRcN3Z8b5Jfd2yMFBSZB
         hx5TR9NcgLkGAhd5lFVbs0VQXt3EMVCvBprSoQsTrT5nYFJg3KbnrHAqEJIb4CAwbRaH
         Z9dcW1Hoz5uDcasHff5qgPkevFZ1Ldc51DjaJujadj7i2bcC8vXn6gt7Scty5aSlV0KK
         B7xTGDMTR3orlQzoqFpdkPJBaUQgU0augBFtBOdY4TxW9bn7FqCrFw5NcZYgJcgAB/bt
         rBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ee5qM+UNNhRdG2dNaTXRGtyqNayzs63lsgczoaNreJM=;
        b=XDdcyP+jjR8gQfvK07XhoJ1lgv5ZS9OXXa42cU/+GaUd1xAwWho5Vb49S8AiqeFKUs
         EuLHzm8EeKg6DcWzQLywi/AlxeUfxuvM8sSq4RJPhDE2WR092T4Deq6k1Ol44MPmJbBa
         xDJi3NKDvX+vhSMX+0xReGLe2OZynuX1M1MnZ+VX1eiLx8/RNLqtEx8VXok8J4mPEKDg
         770STDRJ3LUCKqdIdnmcd9bTsycjYx+o9UwC387zkC92ULfvwEA1HDzUvRrd0QJjU9AW
         AdOoTIGQtnX6Np3o3/rU3NcD79QbKkkbNRbmkvdQgMP0+cILNbVWO5b8gyenTfMEaNh3
         Jx5Q==
X-Gm-Message-State: ANhLgQ3uxXVl58q+MZ+q6auOv34wZZ8/N01TlU1b5DmfHD6xBhM6vuZL
        OVrNZyRkr33I2InZ8OWVvqI=
X-Google-Smtp-Source: ADFU+vs9CQcJYrRkELNE3uM4uTdtIU5AZVMSFKAJxnIb14jVUA+B3vZrMjy5wJFaJ5I63TbKsq4eFQ==
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr7415044otr.358.1585252016634;
        Thu, 26 Mar 2020 12:46:56 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id z14sm867885oia.23.2020.03.26.12.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 12:46:55 -0700 (PDT)
Date:   Thu, 26 Mar 2020 12:46:52 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] tracing: Use address-of operator on section symbols
Message-ID: <20200326194652.GA29213@ubuntu-m2-xlarge-x86>
References: <20200220051011.26113-1-natechancellor@gmail.com>
 <20200319020004.GB8292@ubuntu-m2-xlarge-x86>
 <20200319103312.070b4246@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319103312.070b4246@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:33:12AM -0400, Steven Rostedt wrote:
> On Wed, 18 Mar 2020 19:00:04 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > Gentle ping for review/acceptance.
> 
> Hmm, my local patchwork had this patch rejected. I'll go and apply it, run
> some tests and see if it works. Perhaps I meant to reject v1 and
> accidentally rejected v2 :-/
> 
> Thanks for the ping!
> 
> -- Steve

Hi Steve,

Did you ever get around to running any tests? If so, were there any
issues? This warning is one of two remaining across several different
configurations so I sent the patch to turn on the warning and I want
to make sure this gets picked up at some point:

https://lore.kernel.org/lkml/20200326194155.29107-1-natechancellor@gmail.com/

If you have not had time, totally fine, I just want to make sure it does
not fall through the cracks again :)

Thank you,
Nathan

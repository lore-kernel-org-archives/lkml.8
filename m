Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAEEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF0720CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jSEfzXzE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MWxpwFEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGDVZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 17:25:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38542 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgGDVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 17:25:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 348288EE12E;
        Sat,  4 Jul 2020 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593897924;
        bh=fLNQ6d4VgZNzO4C0fql4nUSSP4E1HMcnNHwjRBlqS38=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jSEfzXzEGPQpGZgTuO7n558XbKupxEGM4ec/UKZ5/nAQHrKVQn9Q5emC/KIHUvPMK
         lTcBBUvpM8YTTYW8DTzMjA1QWQbrHrwKbcFLUvbqr9ooz+pdXI7ZASgBBTEaInRqVC
         Dwnx6vjv0JvtUwIERsnoQ3JC8ZSMl2cFCe6Qxjmg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Lq2wohIdSLj6; Sat,  4 Jul 2020 14:25:24 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5BB268EE100;
        Sat,  4 Jul 2020 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593897923;
        bh=fLNQ6d4VgZNzO4C0fql4nUSSP4E1HMcnNHwjRBlqS38=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MWxpwFEOQ9gzwOJ89HrIVizZNBpEf2v7N+WliEgdI3/madcY6YLi6ldin9gv985pD
         TFySuPGQu9wIMQJw/c+0F0kYdTjm5V6FvZKjscOFOpEHx9YfWhbaPhYWS5ahKzKnCf
         mZ4lCC4odeea0Ev9a02WfRXWN+zxfqhv1ogHTc2k=
Message-ID: <1593897917.7058.11.camel@HansenPartnership.com>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        torvalds@linux-foundation.org
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Date:   Sat, 04 Jul 2020 14:25:17 -0700
In-Reply-To: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-04 at 13:02 -0700, Dan Williams wrote:
[...]
> diff --git a/Documentation/process/inclusive-terminology.rst
> b/Documentation/process/inclusive-terminology.rst
> new file mode 100644
> index 000000000000..a8eb26690eb4
> --- /dev/null
> +++ b/Documentation/process/inclusive-terminology.rst

Could we just lose this entire document?  The one thing we should learn
from recent history is that we really want prevent people distracting
from the good inclusive (and technically more accurate) terminology
will do.  One way the detractors do this by engaging in ultimately
pointless arguments about historical accuracy of supporting statements.
  By making pejorative statements about history (which are open to
challenge on several fronts), this document acts as a magnet for such
attention.  Simply leave it out and the detractors will have nothing to
attack except the bald statement of desiring more inclusive language. 
I'd much rather defend why we want inclusive and more descriptive
language than get into a pointless argument over whether the Ottoman
slave trade was more or less evil than the American one.

James


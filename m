Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD95C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C5220857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgDQV1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:27:20 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:40672 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbgDQV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:27:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7C2DF100E7B43;
        Fri, 17 Apr 2020 21:27:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cloth96_79c5a18faf91b
X-Filterd-Recvd-Size: 1404
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Apr 2020 21:27:16 +0000 (UTC)
Message-ID: <b2c2f344419156c75c6f58258cab6e7a60c2d4a9.camel@perches.com>
Subject: Re: checkpatch.pl warning for "return" with value
From:   Joe Perches <joe@perches.com>
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Apr 2020 14:25:04 -0700
In-Reply-To: <8859753b-c7c9-78ec-20cc-ce424b436b13@amd.com>
References: <a1eea414-2422-3a9f-b9bb-1ab7d6113dd6@amd.com>
         <1a47c5c428968a0e1d0ac5b92ce7ebdd4014fd38.camel@perches.com>
         <8859753b-c7c9-78ec-20cc-ce424b436b13@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 14:52 -0400, Luben Tuikov wrote:
> Also checking and returning from a function, doesn't
> always have to be binary. It could be,
> 
> 	if (A) {
> 		...;
> 		return X;
> 	} else if (B) {
> 		...;
> 		return Y;
> 	} else {
> 		...;
> 		return Z;
> 	}
> }
> 
> And interestingly, checkpatch.pl doesn't complain for
> the triplet above. But if I remove condition B, above,
> it does complain.

My recollection is false positives existed so the
else if case was not wanted.



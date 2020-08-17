Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FCFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6AA120716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgHQOXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:23:11 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:52682 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728465AbgHQOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:23:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3EC1D182CF66B;
        Mon, 17 Aug 2020 14:23:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soup81_331683427017
X-Filterd-Recvd-Size: 2118
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 14:23:07 +0000 (UTC)
Message-ID: <fafab4f8754a924a97e2115fbd95085dbf918a9b.camel@perches.com>
Subject: Re: [PATCH] x86: Use fallthrough pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Gustavo A. R. Silva" <kernel.org@embeddedor>
Date:   Mon, 17 Aug 2020 07:23:05 -0700
In-Reply-To: <20200817130227.GI549@zn.tnic>
References: <20200707200303.GA4680@embeddedor>
         <20200817130227.GI549@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-17 at 15:02 +0200, Borislav Petkov wrote:
> On Tue, Jul 07, 2020 at 03:03:03PM -0500, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> ...
> 
> > @@ -362,7 +361,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
> >  		case INAT_SEG_REG_GS:
> >  			return vm86regs->gs;
> >  		case INAT_SEG_REG_IGNORE:
> > -			/* fall through */
> >  		default:
> >  			return -EINVAL;
> >  		}
> > @@ -386,7 +384,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
> >  		 */
> >  		return get_user_gs(regs);
> >  	case INAT_SEG_REG_IGNORE:
> > -		/* fall through */
> >  	default:
> >  		return -EINVAL;
> >  	}
> 
> What's the logic for those two to not get a fallthrough; marker?

consecutive case labels do not need one.



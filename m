Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B58BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE26020658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="J8/Y50VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbgDAPwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:52:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:55305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732683AbgDAPwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585756335;
        bh=3eq5ME+gVr4M1P00oIT+Rc42Nsmquyg/D1KhXARjebc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=J8/Y50VNM29aa4oWf6QVSkMPQ5QldSqWvvWeCCiE8oYn8Qo9Ne/tu8VYbo8F2+pIp
         ARnjLv4x73vE+/4CSfBtvRcBPhbbnVlRD0wyNB9eA+GY/V89bjEhX5tX8/IGTz56zn
         gy7/+1Sp5OFpjjiA/16bloA52QB0ACOAlDXHHnu4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAOJP-1jVSI01FWt-00BxKb; Wed, 01
 Apr 2020 17:52:15 +0200
Date:   Wed, 1 Apr 2020 17:52:13 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: vt6656: Define EnCFG_BBType_MASK as OR between
 previous defines
Message-ID: <20200401155212.GB3109@ubuntu>
References: <20200327165802.8445-1-oscar.carter@gmx.com>
 <20200330122714.GA113453@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330122714.GA113453@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:dB1hbiDlJbRfAbWMS4n1nBjXSFgq/QwnCi6DMfpH0RNAsTOgxgH
 XCWhs4ZSr/MwKu4I/nOOSHNtvdzH+iYqOmQQnYlAXl0quY/fjEIZQSCP71kySq2b0hlMGRB
 Sv3JDtW4TPXt4YhaozzHcbnT+315pcpqcKogNwF+PjrX+6rLsHweLHH5BiTJFZQ9UaTwt+0
 gvM8cYc6Mi8bfkQ2AYZBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7uJTvMvfw4I=:avgJoEJvY6zy5SsYKojpA1
 ChGOVZmebOVws/0GN+ZZB5Xvt3AQ6iQzbNxs4D/IbELyI+ZiRAD7MkjmyogUhcq0e5CMRdmKC
 61DcSLgnJ6rtfW6k7Oz4PQ/a+PDRJbqban2SWGv9Ol9EaHfx8xWyCj+hY7UEPo6gXfNnKFJEc
 t9czfb+F62AUgW+cwljyaTjIcdzVcANx246pc/8MqFIk1cm/JJcqHDsh/hPisMJjDYwvk78Nr
 QcB8bM2EV0X5vIwPTyRNWxd0c2EGn8wpwYTJAjgYAWcsS1eqmzO2dlfIJjFir0Uxm5Wd52Too
 lDMdfI7TFYuvqtox4VmtNQk705laPv4wz60cB4l5UDoxWIhLNMjtv6sWwW66n4OT35VoakWY4
 3+n2MBwoiWONfEzPoqq/viKjiS1JDqF9MNOMpB+52e0OIMT/8aR9khXcbHh3DHWu4nekZPSuS
 bHGdc+Ld9L88qEtMFu9dqRu8V7lt0nMI4IiSCEBNj51OjOlT+VTccgzc2939GLJKn11SpSt0D
 P7CzMqsvQF75mqKdh4v0JLsj6B2Gp1t/2KDpgiXPkbzORY82pYC5zPfjAa2JzQj3kADzIM/u9
 UjIch6GPUL8yU6itbKykrBeDVD91lJPKn63GU9K0PMiVb00IODoIPeGh03flFmN/XdCeAyQnB
 B2YC/QGdC9tm042h1q/6HGH5yWkxDmTo2avlkfumVLpgfgl9HRxa6xVU0+Mp5zifbjNVp9uA1
 rml0ipCLbhkAZKnw+UDkErwIarxnJtgXijHflnNs0vsZkSHz4fJwtjHG5iYOluD/QtBR94gYW
 Hg887eXVgwnkXT6THYbgw/2OCQ/uXDipKTvzlyL5q9NmlN8szm60a14zXv7ISfgomU51gDf5X
 P5n1TTxtJOsvdgQGuskdBbIFd2uYKbmLMcgPPUqIBoiP0lkEXo8nn0kLMlksv4gdxELo7A42k
 R4AowL2634Z1CDQJfImXUwlNMtODMw4rBppxvioGWCuugSY85o1AsAAqYd/qPGHP1qfx0Adxx
 50pzKBInILBL71WDmI7/D284WwuQA5oQM7yrPUTUqgMuSQHdSQZZFZAtfgE3R06Hx1V2WcWpL
 dyYjmytQRFFL/0OIz0n2H+xHK7108GUBiBFPSkjH324zskzAbe6owwFjKFja7GysStvewr06E
 Hygc+/8GyfM75hitsiEO8a5FX+sl2LFIjf629kbbP0wEm8ZS8JY9QSAbGl98C7ETxK/0cnJZq
 S1x5i87Tpafkt1EZf
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:27:14PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Mar 27, 2020 at 05:58:02PM +0100, Oscar Carter wrote:
> > Define the EnCFG_BBType_MASK bit as an OR operation between two previo=
us
> > defines instead of using the OR between two new BIT macros. Thus, the
> > code is more clear.
> >
> > Fixes: a74081b44291 ("staging: vt6656: Use BIT() macro instead of hex =
value")
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/staging/vt6656/mac.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac=
.h
> > index c532b27de37f..b01d9ee8677e 100644
> > --- a/drivers/staging/vt6656/mac.h
> > +++ b/drivers/staging/vt6656/mac.h
> > @@ -177,7 +177,7 @@
> >  #define EnCFG_BBType_a		0x00
> >  #define EnCFG_BBType_b		BIT(0)
> >  #define EnCFG_BBType_g		BIT(1)
> > -#define EnCFG_BBType_MASK	(BIT(0) | BIT(1))
> > +#define EnCFG_BBType_MASK	(EnCFG_BBType_b | EnCFG_BBType_g)
>
> This does not "fix" anything, like your "Fixes:" tag implies.  It just
> cleans up the code some more.  Only use Fixes: if it actually fixes a
> problem introduced by a previous patch.
>
Ok, thanks for the explanation.

> Can you remove that line and resend?
>
Yes, I will remove that line, I will create a new version of this patch an=
d I
will resend it.

> thanks.
>
> greg k-h

Thanks,
oscar carter

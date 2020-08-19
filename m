Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB739204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="UpV5SS8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgHSNgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:36:02 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:33137 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728677AbgHSNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:35:33 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 8OFWkczRvuuXO8OFXkhIqg; Wed, 19 Aug 2020 15:35:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1597844131; bh=JoJk6PQwKHAww8429MNRXvNAiYmT4d6i0AbGAcqUTo0=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=UpV5SS8w5YmzqI0GPyBu/crNVaQs1Du44S5/XfPTPzLdCl9MYOiyxMyR9No1qkX/s
         bEEgwbMibNzY1kI9OqUkiGLjS9V2qfKi0vubswKQUSmob6sRGDkzDuEXjytQxvLNzc
         87QQ4FVaRCxSQ52RcUHy+/IS9szaqrd/EF/pwBqQMYgyvt1h2SAiDh6nLfS3uVtynY
         bPGxRHG6xVTKfoa7gzvV1wR11jeIslyWNIRg8G1Ol1Yzb+soAIRoIbrUUx6JA/x1Vy
         XhN08wGjYgoSjK/QiEnZlmo2MjhM0p6EkaayZ4Q4xNPPJWGzNCkYmyPoLY0XZ8QwcV
         xa5lAVtAnnIfw==
Subject: Re: [PATCH 14/20] media: dvb-frontends: lgdt3306a.c: remove dead code
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <20200807083548.204360-14-dwlsalmeida@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <378b3a76-1d14-8c69-f9be-3749e6c3c083@xs4all.nl>
Date:   Wed, 19 Aug 2020 15:35:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807083548.204360-14-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIqRJmjIWggj6fX3RMF20X9mlA0SwD7WdWUG0v5QjuUeDiYl6yFxbkTSeU88dzzPtmhGCdsrafDeHuGpxOD1fhZjWJvVXd99duHxBS1CC1Uns3Ug271A
 ohYE0Mrk1jCVGTen/5itAIZCJS7lir220ii+KAt/8hxEMcWOktkuqRd63oFLRg56a98ihJPbOTj6z/kvpukiVu4BN6XM8Z47tnFtEK+POXPwKeW06PY+cMFk
 GtjO0lUXXxdsPdnZBxwcz8Dhy9nP8SRfTZybgcTY8yBqY3ZrZjU0q9baObtsXQ/iO8PAKJIGui1q9g5SoJWxE+eqnt1ZdaWDA7EZOHeMMXpnJGP4JD8UBRRj
 wysWefukmTJ+MHErsD10RwpGTnhSqWOsIzhHimdkugG9vVEJOyREr8IPJHlPMYrwYS6on21q
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2020 10:35, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix the following coccinelle report:
> 
> drivers/media/dvb-frontends/lgdt3306a.c:718:5-8:
> Unneeded variable: "ret". Return "0" on line 744
> 
> Code was enclosed with #if 0 and thus this variable was not needed.
> Remove that code altogether.
> 
> Found using - Coccinelle (http://coccinelle.lip6.fr)
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  drivers/media/dvb-frontends/lgdt3306a.c | 27 +------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
> index d3c330e035c4..0247ef799546 100644
> --- a/drivers/media/dvb-frontends/lgdt3306a.c
> +++ b/drivers/media/dvb-frontends/lgdt3306a.c
> @@ -715,33 +715,8 @@ static int lgdt3306a_spectral_inversion(struct lgdt3306a_state *state,
>  				       struct dtv_frontend_properties *p,
>  				       int inversion)
>  {
> -	int ret = 0;
> -
>  	dbg_info("(%d)\n", inversion);
> -#if 0
> -	/*
> -	 * FGR - spectral_inversion defaults already set for VSB and QAM;
> -	 * can enable later if desired
> -	 */
> -
> -	ret = lgdt3306a_set_inversion(state, inversion);
> -
> -	switch (p->modulation) {
> -	case VSB_8:
> -		/* Manual only for VSB */
> -		ret = lgdt3306a_set_inversion_auto(state, 0);
> -		break;
> -	case QAM_64:
> -	case QAM_256:
> -	case QAM_AUTO:
> -		/* Auto ok for QAM */
> -		ret = lgdt3306a_set_inversion_auto(state, 1);
> -		break;
> -	default:
> -		ret = -EINVAL;
> -	}
> -#endif
> -	return ret;
> +	return 0;
>  }
>  
>  static int lgdt3306a_set_if(struct lgdt3306a_state *state,
> 

You can drop the lgdt3306a_spectral_inversion function completely
since the function doesn't do anything. It would be good to replace
the function call with the comment "spectral_inversion defaults already
set for VSB and QAM" so that information isn't lost.

Regards,

	Hans

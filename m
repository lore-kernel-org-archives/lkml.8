Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49054C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2549720B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qAPJpIFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD2Qn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:43:28 -0400
Received: from mout.web.de ([212.227.15.14]:41353 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgD2Qn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588178584;
        bh=u6deDAh7ES+ICnOxX8IAfRbiNhwow9Wm9VkG7jWeJMQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qAPJpIFJ0m068bk0NSfqPuhirtGk8Im2OeBoVl1PIGSwoFfnQPsFndFQobhuPlyyY
         NNsFYhOcbaobrabnqlZqC+AmPfYBpx13bTEB7DuMghr86uZMI3yQPYCEE3U9o2vRPO
         /dM8PrLbyAiKJUai9rvKvrmYm+cnnNpJvWcDs74g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MarqU-1jjqFZ3CDC-00KMRk; Wed, 29
 Apr 2020 18:43:03 +0200
Subject: Re: [PATCH v3] mm/slub: Fix incorrect interpretation of s->offset
To:     Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Changbin Du <changbin.du@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <20200429135328.26976-1-longman@redhat.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <af19e771-062f-6ed7-0b9a-e8cd8d0fdb6a@web.de>
Date:   Wed, 29 Apr 2020 18:42:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429135328.26976-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wd3kwhLX6DwLMhulDGytN53sy45DgtwHEfXLhvkjJXm2ZRuqyJu
 /DRDPYshaufW+wg8qvDGJt6Rrxry3w4xL95irPXpWvBOth43Ey2AcTLWt23cH3hAGP7Bx2X
 /tdQWN6lfm5tOB6rFXZLYmt8YTbq4SetObF/HSl6N4ye9L0fVUlEJaJR4n3agQ4BebdmSyN
 JsRoTf9Z2kxGKYZjGt/EQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E0Z8We4+zbY=:ralSufDbuJakJ81Dc+Hzuq
 FRHtzfgtBW/L4J8E93MQ93uDoqsdOfg/k40ou+3syYItneL1tVrFJoC+90kwgQnL46dkM6b47
 pWouFzesFYVtk7zcoZZ+2TVNCGUCfE589nQxh+D85fjB+WaasTy3Klv3H0vwwDatamU4E8MhJ
 b0/fhAQ3wLxERlTHD8NA8PXOaM9NW91bG0SBCLAaEeNJ7yvE7ng+AfsZNqh8JilO7vH/1+aQa
 cJSo6MgN/s1j9vSxYTLms4G4qSL9DIzcoTLRz5K1ZLdoFo9olkBpWUqzfkYL/TFMPKs6whURQ
 RhEalFb/Apa3advZVBd9ULynjWgvugxURcqPmCnSMzdLJNF1pPZZppcbCVC+Lx0lbeT5kTBFC
 4h2jmyeSFYhTH+PsW4AN+jq0UXcC1ezotL25ebF6arztYnQMxxATaRp7BnuioVUJGcN/RXlpC
 DJscTTxTwytwYMyl1hJwaMo8fQ1/LvC+dDSFaftjgMBPFcBZY/udzsbmF+Mv8O6V6Ki50kxkq
 khWXsILYke/GzvxtzWuR1s7ycJPlXoepgsUlG3Dum2/F1wsEyYW5Wlytr9bdiGszJU0wurB3c
 4EVS8iSWQdNULKhf2TNlo4RlvX9iGeXdyO4t83TsTOsziGV5ansJ85Vt3viFVS7/cK3v6VN87
 f+wrCt9qUTuvXX+9YlV4CkvXYRkVh7/+9KCdzuFFEQQlOday7aSr72z63pB6Em1HfAJU+suq2
 ZzVaI5eayjDihzBfCIAz1KUEeXJPm53WvG7hpW8l3h1ZFv7d9OtMfd+nxTDcDY8Mpi/HVvOh4
 7F5+2fSLPLr5zAMB9OsnPDQyXy0BJcjAMGB4ouFa9cxmE9btsE/4PmX41oJ9U6eDWJKbLQIkM
 +0byTondrA9HqO4bNHXoGb47vZ4ERDL7v+M0wVpJu3QBG/MGPk2OSRi4O26nrf8nhIXMyJiXy
 vodgRn6K9GlJ/+f8c7mYyUduC3irGJSurzhH9Nf0yTz94wt0KuLck8HoYdXtPoUXA6jNd+rR0
 6GrrPnLHsz4AqerLvRORppwjNG8m6vzmOCIIV/5rdD2ZmKMNUQ6HYEr9XBFwFmDR8s9OvNhJ1
 y0eesQAXBql7nz10mBzDnJsrMS/Sxm+lytiVtJgpqnAXyhqcIpLJOKKA97IuA4zBfSByfExw7
 VVfnBRMoDl1wwNbGENzgwEv2+vjEUG6l/mNb6YRkRg11yjkmcpcVfvMoxWflOKEv4rb12nfGr
 eEaOjokPIb1MlXNHI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In a couple of places in the slub memory allocator, the code uses
> "s->offset" as a check to see if the free pointer is put right after the
> object. That check is no longer true with commit 3202fa62fb43 ("slub:
> relocate freelist pointer to middle of object").

Will any further collateral evolution become interesting?


=E2=80=A6
> +++ b/mm/slub.c
> @@ -551,15 +551,32 @@ static void print_section(char *level, char *text,=
 u8 *addr,
=E2=80=A6
> +static inline unsigned int get_info_end(struct kmem_cache *s)
> +{
> +	if (freeptr_outside_object(s))
> +		return s->inuse + sizeof(void *);
> +	else
> +		return s->inuse;
> +}

How do you think about the following source code variants?

+	return freeptr_outside_object(s)
+	       ? s->inuse + sizeof(void *)
+	       : s->inuse;


>  static struct track *get_track(struct kmem_cache *s, void *object,
>  	enum track_item alloc)
>  {
>  	struct track *p;
>
> -	if (s->offset)
> -		p =3D object + s->offset + sizeof(void *);
> -	else
> -		p =3D object + s->inuse;
> +	p =3D object + get_info_end(s);
>
>  	return p + alloc;
>  }

+	struct track *p =3D object + get_info_end(s);

 	return p + alloc;


Regards,
Markus

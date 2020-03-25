Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE86C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517172076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avKWT/7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgCYNgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:36:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25349 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbgCYNgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585143360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTWSDBTYwDIzFD3B1k+QGH19Oi5HErFXNjNfQmqBD2w=;
        b=avKWT/7P94lIHLUrZjTxZ/DnRj8NegKYF+3XfU+0mjw4iv/yZFUNQ6LKVmnPQNV92F4fGT
        mXC+xpVXf7vs/fLgQ88CqhFisc90oJaCBfzTw0puy2W4Vuo+PYYmYORE9q4AXJgoE6w1N1
        cMHSI31snokN83TFc+Ou8A8hFdpCTVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-zXJVW8PNPOGmt8hrMMw9Pg-1; Wed, 25 Mar 2020 09:35:56 -0400
X-MC-Unique: zXJVW8PNPOGmt8hrMMw9Pg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61B78107ACC4;
        Wed, 25 Mar 2020 13:35:55 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2B1CBBBDD;
        Wed, 25 Mar 2020 13:35:54 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 63859160; Wed, 25 Mar 2020 10:35:51 -0300 (BRT)
Date:   Wed, 25 Mar 2020 10:35:51 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>, He Zhe <zhe.he@windriver.com>
Cc:     tstoyanov@vmware.com, hewenliang4@huawei.com,
        linux-kernel@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH v3] tools lib traceevent: Take care of return value of
 asprintf
Message-ID: <20200325133551.GA19495@redhat.com>
References: <1582163930-233692-1-git-send-email-zhe.he@windriver.com>
 <5f7589c3-323d-1a5c-685c-9becd87a690b@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f7589c3-323d-1a5c-685c-9becd87a690b@windriver.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:05:46PM +0800, He Zhe escreveu:
> Can this be considered for the moment?

Rostedt, have you looked at this?

- Arnaldo
=20
> Thanks,
> Zhe
>=20
> On 2/20/20 9:58 AM, zhe.he@windriver.com wrote:
> > From: He Zhe <zhe.he@windriver.com>
> >
> > According to the API, if memory allocation wasn't possible, or some o=
ther
> > error occurs, asprintf will return -1, and the contents of strp below=
 are
> > undefined.
> >
> > int asprintf(char **strp, const char *fmt, ...);
> >
> > This patch takes care of return value of asprintf to make it less err=
or
> > prone and prevent the following build warning.
> >
> > ignoring return value of =E2=80=98asprintf=E2=80=99, declared with at=
tribute warn_unused_result [-Wunused-result]
> >
> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > ---
> > v2: directly check the return value without saving to a variable
> > v3: as asked, not remove those that already save the return value
> >
> >  tools/lib/traceevent/parse-filter.c | 29 +++++++++++++++++++--------=
--
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceeve=
nt/parse-filter.c
> > index 20eed71..c271aee 100644
> > --- a/tools/lib/traceevent/parse-filter.c
> > +++ b/tools/lib/traceevent/parse-filter.c
> > @@ -1958,7 +1958,8 @@ static char *op_to_str(struct tep_event_filter =
*filter, struct tep_filter_arg *a
> >  				default:
> >  					break;
> >  				}
> > -				asprintf(&str, val ? "TRUE" : "FALSE");
> > +				if (asprintf(&str, val ? "TRUE" : "FALSE") < 0)
> > +					str =3D NULL;
> >  				break;
> >  			}
> >  		}
> > @@ -1976,7 +1977,8 @@ static char *op_to_str(struct tep_event_filter =
*filter, struct tep_filter_arg *a
> >  			break;
> >  		}
> > =20
> > -		asprintf(&str, "(%s) %s (%s)", left, op, right);
> > +		if (asprintf(&str, "(%s) %s (%s)", left, op, right) < 0)
> > +			str =3D NULL;
> >  		break;
> > =20
> >  	case TEP_FILTER_OP_NOT:
> > @@ -1992,10 +1994,12 @@ static char *op_to_str(struct tep_event_filte=
r *filter, struct tep_filter_arg *a
> >  			right_val =3D 0;
> >  		if (right_val >=3D 0) {
> >  			/* just return the opposite */
> > -			asprintf(&str, right_val ? "FALSE" : "TRUE");
> > +			if (asprintf(&str, right_val ? "FALSE" : "TRUE") < 0)
> > +				str =3D NULL;
> >  			break;
> >  		}
> > -		asprintf(&str, "%s(%s)", op, right);
> > +		if (asprintf(&str, "%s(%s)", op, right) < 0)
> > +			str =3D NULL;
> >  		break;
> > =20
> >  	default:
> > @@ -2011,7 +2015,8 @@ static char *val_to_str(struct tep_event_filter=
 *filter, struct tep_filter_arg *
> >  {
> >  	char *str =3D NULL;
> > =20
> > -	asprintf(&str, "%lld", arg->value.val);
> > +	if (asprintf(&str, "%lld", arg->value.val) < 0)
> > +		str =3D NULL;
> > =20
> >  	return str;
> >  }
> > @@ -2069,7 +2074,8 @@ static char *exp_to_str(struct tep_event_filter=
 *filter, struct tep_filter_arg *
> >  		break;
> >  	}
> > =20
> > -	asprintf(&str, "%s %s %s", lstr, op, rstr);
> > +	if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
> > +		str =3D NULL;
> >  out:
> >  	free(lstr);
> >  	free(rstr);
> > @@ -2113,7 +2119,8 @@ static char *num_to_str(struct tep_event_filter=
 *filter, struct tep_filter_arg *
> >  		if (!op)
> >  			op =3D "<=3D";
> > =20
> > -		asprintf(&str, "%s %s %s", lstr, op, rstr);
> > +		if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
> > +			str =3D NULL;
> >  		break;
> > =20
> >  	default:
> > @@ -2148,8 +2155,9 @@ static char *str_to_str(struct tep_event_filter=
 *filter, struct tep_filter_arg *
> >  		if (!op)
> >  			op =3D "!~";
> > =20
> > -		asprintf(&str, "%s %s \"%s\"",
> > -			 arg->str.field->name, op, arg->str.val);
> > +		if (asprintf(&str, "%s %s \"%s\"",
> > +			 arg->str.field->name, op, arg->str.val) < 0)
> > +			str =3D NULL;
> >  		break;
> > =20
> >  	default:
> > @@ -2165,7 +2173,8 @@ static char *arg_to_str(struct tep_event_filter=
 *filter, struct tep_filter_arg *
> > =20
> >  	switch (arg->type) {
> >  	case TEP_FILTER_ARG_BOOLEAN:
> > -		asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
> > +		if (asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE") < 0)
> > +			str =3D NULL;
> >  		return str;
> > =20
> >  	case TEP_FILTER_ARG_OP:


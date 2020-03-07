Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3CDC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EA020665
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 19:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wH3cRoyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCGTmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 14:42:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51136 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgCGTmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 14:42:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 027JeDht052378;
        Sat, 7 Mar 2020 19:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Gco4zpX77QENpnAf0FH8U/HTthlZKiexOOsjBR2Zhv0=;
 b=wH3cRoytj5ulOq8EkBTN8Q6fSBdVbUBAyw36JCE9XBjfdkUsplqFm+E2h6DXZ3NAX9ta
 aS2fkpwQB2crFaoIVGVyoGEHygEpAAdyCWN1Ktduvqhgbz6CQMRVj4hvVAJ564toj/hu
 yTHLKNihhgHesj/6PSKi0MqBEk0K7fSz0ottbnU2lp8P8HMtqitn5pIawAyOaa5FENuL
 OYR/iXaefC/r8olIbrLT8InzK7Hn4HwHYWqMpq65lv18E7S4tjHtlh9iP43VSPeXmN35
 v8l55v/E3TAkK6AGjthCReoKKR+4acRtNxTOLEuatAUy1JfKJbbWZync1XRkwYYIJNQm 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ym48shfqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 19:41:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 027Jb5IC189059;
        Sat, 7 Mar 2020 19:41:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ym3e7ya17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 19:41:53 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 027Jfp1x003314;
        Sat, 7 Mar 2020 19:41:51 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 07 Mar 2020 11:41:51 -0800
Subject: Re: [PATCH v2] xen: Use evtchn_type_t as a type for event channels
To:     Yan Yankovskyi <yyankovskyi@gmail.com>,
        Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200307134322.GA27756@kbp1-lhp-F74019>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Autocrypt: addr=boris.ostrovsky@oracle.com; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <d190793c-fe6b-263e-7793-ccd73f9ccad4@oracle.com>
Date:   Sat, 7 Mar 2020 14:41:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307134322.GA27756@kbp1-lhp-F74019>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9553 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=2 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003070144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9553 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=2 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003070144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/20 8:43 AM, Yan Yankovskyi wrote:
> Make event channel functions pass event channel port using
> evtchn_port_t type. It eliminates signed <-> unsigned conversion.
>


>  static int find_virq(unsigned int virq, unsigned int cpu)
>  {
>  	struct evtchn_status status;
> -	int port, rc =3D -ENOENT;
> +	evtchn_port_t port;
> +	int rc =3D -ENOENT;
> =20
>  	memset(&status, 0, sizeof(status));
>  	for (port =3D 0; port < xen_evtchn_max_channels(); port++) {
> @@ -962,7 +963,8 @@ EXPORT_SYMBOL_GPL(xen_evtchn_nr_channels);
>  int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)=

>  {
>  	struct evtchn_bind_virq bind_virq;
> -	int evtchn, irq, ret;
> +	evtchn_port_t evtchn =3D xen_evtchn_max_channels();
> +	int irq, ret;
> =20
>  	mutex_lock(&irq_mapping_update_lock);
> =20
> @@ -990,7 +992,6 @@ int bind_virq_to_irq(unsigned int virq, unsigned in=
t cpu, bool percpu)
>  			if (ret =3D=3D -EEXIST)
>  				ret =3D find_virq(virq, cpu);
>  			BUG_ON(ret < 0);
> -			evtchn =3D ret;


This looks suspicious. What would you be passing to
xen_irq_info_virq_setup() below?

I also think that, given that this patch is trying to get types in
order, find_virq() will need more changes: it is supposed to return
evtchn_port_t. But then it also wants to return a (signed) error.

>  		}
> =20
>  		ret =3D xen_irq_info_virq_setup(cpu, irq, evtchn, virq);
> @@ -1019,7 +1020,7 @@ static void unbind_from_irq(unsigned int irq)
>  	mutex_unlock(&irq_mapping_update_lock);
>  }
> =20



> --- a/drivers/xen/xenbus/xenbus_client.c
> +++ b/drivers/xen/xenbus/xenbus_client.c
> @@ -391,7 +391,7 @@ EXPORT_SYMBOL_GPL(xenbus_grant_ring);
>   * error, the device will switch to XenbusStateClosing, and the error =
will be
>   * saved in the store.
>   */
> -int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port)
> +int xenbus_alloc_evtchn(struct xenbus_device *dev, evtchn_port_t *port=
)

Right. But then why is the declaration in include/xen/xenbus.h (at the
very end of the patch) different?

>  {
>  	struct evtchn_alloc_unbound alloc_unbound;
>  	int err;
> @@ -414,7 +414,7 @@ EXPORT_SYMBOL_GPL(xenbus_alloc_evtchn);
>  /**
>   * Free an existing event channel. Returns 0 on success or -errno on e=
rror.
>   */
> -int xenbus_free_evtchn(struct xenbus_device *dev, int port)
> +int xenbus_free_evtchn(struct xenbus_device *dev, evtchn_port_t port)

Here too.

>  {
>  	struct evtchn_close close;
>  	int err;
> @@ -423,7 +423,7 @@ int xenbus_free_evtchn(struct xenbus_device *dev, i=
nt port)

And why not here, especially since you updated format?

> =20
>  	err =3D HYPERVISOR_event_channel_op(EVTCHNOP_close, &close);
>  	if (err)
> -		xenbus_dev_error(dev, err, "freeing event channel %d", port);
> +		xenbus_dev_error(dev, err, "freeing event channel %u", port);
> =20
>  	return err;
>  }



> =20
> diff --git a/include/xen/interface/event_channel.h b/include/xen/interf=
ace/event_channel.h
> index 45650c9a06d5..cf80e338fbb0 100644
> --- a/include/xen/interface/event_channel.h
> +++ b/include/xen/interface/event_channel.h
> @@ -220,7 +220,7 @@ struct evtchn_expand_array {
>  #define EVTCHNOP_set_priority    13
>  struct evtchn_set_priority {
>  	/* IN parameters. */
> -	uint32_t port;
> +	evtchn_port_t port;

This definition comes from Xen so I think it needs to be fixed there firs=
t.

>  	uint32_t priority;
>  };
> =20
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index 89a889585ba0..4f35216064ba 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -218,8 +218,8 @@ int xenbus_unmap_ring(struct xenbus_device *dev,
>  		      grant_handle_t *handles, unsigned int nr_handles,
>  		      unsigned long *vaddrs);
> =20
> -int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port);
> -int xenbus_free_evtchn(struct xenbus_device *dev, int port);
> +int xenbus_alloc_evtchn(struct xenbus_device *dev, unsigned int *port)=
;
> +int xenbus_free_evtchn(struct xenbus_device *dev, unsigned int port);

These.


-boris


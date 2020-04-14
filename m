Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF6DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D5E206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s38jFPzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632858AbgDNUPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2632822AbgDNUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:14:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BE6C03C1A6;
        Tue, 14 Apr 2020 13:05:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c138so446819pfc.0;
        Tue, 14 Apr 2020 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WO49U3CojIPJ8FYnW7/AVcVTFMeuQ1/UiHUfJDgiAxU=;
        b=s38jFPzpMQyzrgRfWEkRVpx3BQrmGDSC0GnahsExhsMBKjp1EPkClCuHwMlyRK95Vp
         pem2yrn0Dyg/Gh4n7C07N1viukHCOClXz72Vws42txesS7kQk4qAmOV/vTY5xSPf89wx
         kr65R3IHfA+nwsCKH0IbPNjt37z1IVDXiKmbZsVO/xC2aQYqb9LUbab15ypr1Rs/jJgf
         1cHYzmzsIXswfqbOSt2O34U20XbufjphXF2Z4J0wgSaCU3MGbRtW3ACqyeAtIDKkp8Hq
         FFf7Dg9dlEq/ChafohjggQqXrTf8/+7RR8uJNBYohTVD/SeCVCFujhQXZqapAODAODmI
         E31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WO49U3CojIPJ8FYnW7/AVcVTFMeuQ1/UiHUfJDgiAxU=;
        b=HeBSABfnxM2ciE3mAmds4sjx7LHtxOJhe2hG4pNvhxPox8QWrOIUXpIkHjZhAMS7HP
         QfY46sCNLYTfmAMU67Du1MKlRSRcSDgLvEKBaKUaWTTLllVexHs5zf2VtWG++4+I5S1p
         ilaEALK/WZSvT27tVgFjVxJaUjuMuU+UxpP4jpDcGogDV5pjS5vlKexTPg9WGbteOiDD
         RSWXO5e9TkdR1r9gkiYQrICDmOlVi3rIdu76W9OSOaHy9hCyo9Wh6+T0KGq9+beoukyx
         iy8oNAH/kwLjDThiTQOu43hTQ8Uxwhr+udOP0vlqxWZaxwye0TjRQUOTjbh2KrY+K0cZ
         YZEg==
X-Gm-Message-State: AGi0PubuA00rI44aBptrpqqVwsI3pvPK8zZAULpkF70/E2SjaixYuFYE
        fcyhJihTPlDKnrIATWzU7JypvphI
X-Google-Smtp-Source: APiQypIOPv72sj9XFebTeXkfUnAvmlFr5j/fB4pQD4Stl52w0o+TJYZ+nI+Squ24ZpUBlPkqB3eVIQ==
X-Received: by 2002:a62:cfc3:: with SMTP id b186mr24120852pfg.311.1586894724786;
        Tue, 14 Apr 2020 13:05:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a22sm6626136pfg.169.2020.04.14.13.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 13:05:23 -0700 (PDT)
Subject: Re: [PATCH v1] usb: typec: tcpm: Ignore CC and vbus changes in
 PORT_RESET change
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200402215947.176577-1-badhri@google.com>
 <20200414120407.GE2828150@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c2f718cc-4a3a-7b83-da7d-fe739ee0909a@roeck-us.net>
Date:   Tue, 14 Apr 2020 13:05:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414120407.GE2828150@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/20 5:04 AM, Heikki Krogerus wrote:
> On Thu, Apr 02, 2020 at 02:59:47PM -0700, Badhri Jagan Sridharan wrote:
>> After PORT_RESET, the port is set to the appropriate
>> default_state. Ignore processing CC changes here as this
>> could cause the port to be switched into sink states
>> by default.
>>
>> echo source > /sys/class/typec/port0/port_type
>>
>> Before:
>> [  154.528547] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms
>> [  154.528560] CC1: 0 -> 0, CC2: 3 -> 0 [state PORT_RESET, polarity 0, disconnected]
>> [  154.528564] state change PORT_RESET -> SNK_UNATTACHED
>>
>> After:
>> [  151.068814] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms [rev3 NONE_AMS]
>> [  151.072440] CC1: 3 -> 0, CC2: 0 -> 0 [state PORT_RESET, polarity 0, disconnected]
>> [  151.172117] state change PORT_RESET -> PORT_RESET_WAIT_OFF [delayed 100 ms]
>> [  151.172136] pending state change PORT_RESET_WAIT_OFF -> SRC_UNATTACHED @ 870 ms [rev3 NONE_AMS]
>> [  152.060106] state change PORT_RESET_WAIT_OFF -> SRC_UNATTACHED [delayed 870 ms]
>> [  152.060118] Start toggling
> 
> Guenter, can you take a look at this?
> 

Sorry, looks like I missed the original patch. Makes sense to me.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>> ---
>>  drivers/usb/typec/tcpm/tcpm.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index de3576e6530ab2..82b19ebd7838e0 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -3794,6 +3794,14 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
>>  		 */
>>  		break;
>>  
>> +	case PORT_RESET:
>> +	case PORT_RESET_WAIT_OFF:
>> +		/*
>> +		 * State set back to default mode once the timer completes.
>> +		 * Ignore CC changes here.
>> +		 */
>> +		break;
>> +
>>  	default:
>>  		if (tcpm_port_is_disconnected(port))
>>  			tcpm_set_state(port, unattached_state(port), 0);
>> @@ -3855,6 +3863,15 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
>>  	case SRC_TRY_DEBOUNCE:
>>  		/* Do nothing, waiting for sink detection */
>>  		break;
>> +
>> +	case PORT_RESET:
>> +	case PORT_RESET_WAIT_OFF:
>> +		/*
>> +		 * State set back to default mode once the timer completes.
>> +		 * Ignore vbus changes here.
>> +		 */
>> +		break;
>> +
>>  	default:
>>  		break;
>>  	}
>> @@ -3908,10 +3925,19 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>>  	case PORT_RESET_WAIT_OFF:
>>  		tcpm_set_state(port, tcpm_default_state(port), 0);
>>  		break;
>> +
>>  	case SRC_TRY_WAIT:
>>  	case SRC_TRY_DEBOUNCE:
>>  		/* Do nothing, waiting for sink detection */
>>  		break;
>> +
>> +	case PORT_RESET:
>> +		/*
>> +		 * State set back to default mode once the timer completes.
>> +		 * Ignore vbus changes here.
>> +		 */
>> +		break;
>> +
>>  	default:
>>  		if (port->pwr_role == TYPEC_SINK &&
>>  		    port->attached)
>> -- 
>> 2.26.0.292.g33ef6b2f38-goog
> 
> thanks,
> 


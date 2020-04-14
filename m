Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E53C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 05:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F36920678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 05:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20150623.gappssmtp.com header.i=@easyb-ch.20150623.gappssmtp.com header.b="tXhojAcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405585AbgDNFpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 01:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgDNFph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:45:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE368C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 22:45:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d27so3641293wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rOW6dynMAKqu/sCeM7R667FUjDdvESgKXrplFT0QsGs=;
        b=tXhojAcIq9fWYzR/qYmF2Jswf+ij4dvIINeUt2DYgDTlv7KAKac7GsBulV0wPb0PFt
         pS9mMwfiKlSSWzUXnXLwj7au8zClvISJPZJsXU1SSFgF067caAsSq6uap5r6UZatUCuR
         GuHYMhmBfhYlIKQvJ/7DgFJ1itLJd485ZPUBeGgQMurktfe1EpXFB/PGuaLLYQ6atrpU
         PPZtKFVyE3xY8LG40hjE3/mpCuMWcFMqPAARs0E50++KVg9BDVfP9E4blL7U0yUxpO60
         Pm+hD4xzj5VTxNiymjpwELtVnNjH1and1zV+TfspiTh4nLip8PQ3tly0Ok1xOFDUUtml
         n3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rOW6dynMAKqu/sCeM7R667FUjDdvESgKXrplFT0QsGs=;
        b=mLiFZolyPfK3IMIgUd6G7jt7TyFoY0GVPsJlQVxkI6d7UhibLeuuwZDmC/uu/JL3gZ
         jfkKisDzxf6iW+y3mWTMtUldX7TVxWryeDZLNlmfay7dMS+1p+nsJ9qHDPpQekSlXg9t
         Iugfs2HYQeLnyPEmsWdj+aqFsgbo9cnlFoySsfuzfzft4bE9aKL3Im0VTCjnqdSEf/0E
         U+wsa/wwZrJDYIjNQzwA3xve6BFGZfXj3oj7hie1Z3/DNBDsIXb6o8+Bi6DoctTgd/G/
         vjn/aA6iLhqH/aRVqUedeGqp3wElakQB+hl8Qj8KPh3F4h+Nw5HnZnijCDXCKtyih7Of
         7mDg==
X-Gm-Message-State: AGi0PuaqpPyBfVwuTPRPYTSFlv+T9xosiniqnZ3V8Z323pef3dyQrhEy
        Nfm4bEt7WvNSsTenytsn9qW9GJrJ4hU=
X-Google-Smtp-Source: APiQypLSttSZrGrEgTtplDxJ+UK+MznmvqNTa43NMUUVrP68zcrT86TO44l3G2xk/zWlTHqgV5slEQ==
X-Received: by 2002:a5d:4452:: with SMTP id x18mr21133563wrr.231.1586843135531;
        Mon, 13 Apr 2020 22:45:35 -0700 (PDT)
Received: from ?IPv6:2001:1715:4e3a:130:e4d1:deb8:5cd5:74eb? ([2001:1715:4e3a:130:e4d1:deb8:5cd5:74eb])
        by smtp.gmail.com with ESMTPSA id j13sm18438662wro.51.2020.04.13.22.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 22:45:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
From:   Ezra Buehler <ezra@easyb.ch>
In-Reply-To: <20200413180440.GA10917@linux.intel.com>
Date:   Tue, 14 Apr 2020 07:45:33 +0200
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D670A3F7-6FE2-4A07-8251-680C2ED27764@easyb.ch>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
 <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
 <20200412170719.GA324408@linux.intel.com>
 <531D50E8-E8FC-402E-9226-6000E8B6E960@easyb.ch>
 <20200413180440.GA10917@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3445.9.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 13 Apr 2020, at 20:04, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>=20
> On Mon, Apr 13, 2020 at 07:02:20AM +0200, Ezra Buehler wrote:
>> Hi Jarkko,
>>=20
>> On 12 Apr 2020, at 19:07, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>=20
>>> On Sun, Apr 12, 2020 at 05:02:27PM +0200, Ezra Buehler wrote:
>>>> Hi Jarkkon,
>>>>=20
>>>>> On 12 Apr 2020, at 16:36, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>>> +        except ProtocolError(e):
>>>>=20
>>>> Should this not be
>>>>=20
>>>>       except ProtocolError as e:
>>>=20
>>> Unless there is a functional difference, does it matter?
>>>=20
>>> /Jarkko
>>=20
>> Well, your patch confuses me a lot. It looks to me like you are =
passing
>> the undefined `e` variable to the constructor.
>>=20
>> When I run flake8 on it I get following error (among others):
>>=20
>>    F821 undefined name 'e'
>=20
> I don't know what flake8 is.

https://flake8.pycqa.org/en/latest/

>> What I suggested is the standard syntax:
>> https://docs.python.org/3/tutorial/errors.html
>=20
> It passed the Python 3 interpreter.

That is because it is technically valid syntax.

>> Did you test this? You should get an error as soon as an exception
>> occurs.
>=20
> Yes. Interpreter did not complain. I did not know that the language
> is broken that way that you have to exercise the code path to get
> a syntax error.

That is due to the dynamic nature of Python. You won=E2=80=99t get a =
syntax
error. You will get an exception:

    NameError: name 'e' is not defined

Python has to assume that `e` might be defined at runtime. However,
style checkers will complain.

>=20
> /Jarkko

Cheers,
Ezra.


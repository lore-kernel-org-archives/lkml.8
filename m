Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10250C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D812065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595963995;
	bh=gDjcYZbTOICEER/aI9jME0q7WCtwyCu+wuaU18h5RG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MyNDqtnDXTriP4wRZ0o1yVeQ+rCedxDjmbFW5AreHq4JvKW9Y9iNUXJijmgMI+/wt
	 snSigdtYGpt1mBwOK0JhGz9Qp2f92lfIUw25oaZMJC0LrGy2Uwj0ORh0Xza6i/Qb7C
	 S53WNeXrZd3IGg2BBMahyBVmyp4ra9nGSdUBbFXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbgG1TTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:19:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38932 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732751AbgG1TTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:19:53 -0400
Received: by mail-io1-f67.google.com with SMTP id z6so22006180iow.6;
        Tue, 28 Jul 2020 12:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ccbJE075Dg4khtgqkJNGNcjYBuurXYxmcn7lYm7LiDk=;
        b=nqDL65ex39IHEb/jwZ3WTLw/sFmOQDab9H45lz1vhbfjyzYn2CkzenWVdO/p0FpOvD
         oKHXa3dItnAyI05LFnwV6jVDr/3Wrzh6QoXBAwQO/kZArgK4sDV4QW/ht+/EUer2vcAv
         aggdUhkJJdE0N/p2Jzi2bmbha0+P4SZzKGdZJWQCu4tlO68GxtDLxudXygfi64YFtzpg
         dZVFZ9+KcDpyAUKUSvlyN4DEW1jqhljOjew4J+wV/fGLgfq3TztuwTeU87G8+4/pXySi
         cHrxBkTeDPSHwsxUejX5rmYLUb+Qg9JtyXJpusAW7gOiUBfDtvgh8OfGktq/pICyJxyq
         X4dw==
X-Gm-Message-State: AOAM530+jtGxx+4uMx2KRgk4mrTvQb7DW5D+SkOhCH1i49hdjVxnZqMA
        GYX0deRIsmWWMNC0PNCaIA==
X-Google-Smtp-Source: ABdhPJxSpYWGzrqxj988x4YIzGkL2gF9jlCizwUDFtUeYV2nkG7DE0Cn+EQ8ZGwxQ/OXOAvNrnrXlg==
X-Received: by 2002:a05:6602:2801:: with SMTP id d1mr23672137ioe.201.1595963991726;
        Tue, 28 Jul 2020 12:19:51 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u12sm7982022ilj.17.2020.07.28.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:19:51 -0700 (PDT)
Received: (nullmailer pid 2785331 invoked by uid 1000);
        Tue, 28 Jul 2020 19:19:50 -0000
Date:   Tue, 28 Jul 2020 13:19:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: add DT bindings for Microchip
 S/PDIF TX Controller
Message-ID: <20200728191950.GA2784080@bogus>
References: <20200728100744.2820112-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728100744.2820112-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 13:07:43 +0300, Codrin Ciubotariu wrote:
> This patch adds DT bindings for the new Microchip S/PDIF TX Controller
> embedded inside sama7g5 SoCs.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  .../bindings/sound/mchp,spdiftx.yaml          | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 774, in resolve_from_url
    document = self.store[url]
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/_utils.py", line 22, in __getitem__
    return self.store[self.normalize(uri)]
KeyError: 'https://devicetree.org/meta-schemas/core.yaml'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 777, in resolve_from_url
    document = self.resolve_remote(url)
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 863, in resolve_remote
    with urlopen(uri) as url:
  File "/usr/lib/python3.6/urllib/request.py", line 223, in urlopen
    return opener.open(url, data, timeout)
  File "/usr/lib/python3.6/urllib/request.py", line 532, in open
    response = meth(req, response)
  File "/usr/lib/python3.6/urllib/request.py", line 642, in http_response
    'http', request, response, code, msg, hdrs)
  File "/usr/lib/python3.6/urllib/request.py", line 564, in error
    result = self._call_chain(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 504, in _call_chain
    result = func(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 756, in http_error_302
    return self.parent.open(new, timeout=req.timeout)
  File "/usr/lib/python3.6/urllib/request.py", line 532, in open
    response = meth(req, response)
  File "/usr/lib/python3.6/urllib/request.py", line 642, in http_response
    'http', request, response, code, msg, hdrs)
  File "/usr/lib/python3.6/urllib/request.py", line 570, in error
    return self._call_chain(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 504, in _call_chain
    result = func(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 650, in http_error_default
    raise HTTPError(req.full_url, code, msg, hdrs, fp)
urllib.error.HTTPError: HTTP Error 404: Not Found

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 64, in <module>
    ret = check_doc(args.yamldt)
  File "/usr/local/bin/dt-doc-validate", line 33, in check_doc
    for error in sorted(dtschema.DTValidator.iter_schema_errors(testtree), key=lambda e: e.linecol):
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 656, in iter_schema_errors
    meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 779, in resolve_from_url
    raise exceptions.RefResolutionError(exc)
jsonschema.exceptions.RefResolutionError: HTTP Error 404: Not Found
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/sound/mchp,spdiftx.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/sound/mchp,spdiftx.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 774, in resolve_from_url
    document = self.store[url]
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/_utils.py", line 22, in __getitem__
    return self.store[self.normalize(uri)]
KeyError: 'https://devicetree.org/meta-schemas/core.yaml'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 777, in resolve_from_url
    document = self.resolve_remote(url)
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 863, in resolve_remote
    with urlopen(uri) as url:
  File "/usr/lib/python3.6/urllib/request.py", line 223, in urlopen
    return opener.open(url, data, timeout)
  File "/usr/lib/python3.6/urllib/request.py", line 532, in open
    response = meth(req, response)
  File "/usr/lib/python3.6/urllib/request.py", line 642, in http_response
    'http', request, response, code, msg, hdrs)
  File "/usr/lib/python3.6/urllib/request.py", line 564, in error
    result = self._call_chain(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 504, in _call_chain
    result = func(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 756, in http_error_302
    return self.parent.open(new, timeout=req.timeout)
  File "/usr/lib/python3.6/urllib/request.py", line 532, in open
    response = meth(req, response)
  File "/usr/lib/python3.6/urllib/request.py", line 642, in http_response
    'http', request, response, code, msg, hdrs)
  File "/usr/lib/python3.6/urllib/request.py", line 570, in error
    return self._call_chain(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 504, in _call_chain
    result = func(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 650, in http_error_default
    raise HTTPError(req.full_url, code, msg, hdrs, fp)
urllib.error.HTTPError: HTTP Error 404: Not Found

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 34, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 557, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 517, in process_schema
    DTValidator.check_schema(schema)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 668, in check_schema
    meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 779, in resolve_from_url
    raise exceptions.RefResolutionError(exc)
jsonschema.exceptions.RefResolutionError: HTTP Error 404: Not Found
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 774, in resolve_from_url
    document = self.store[url]
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/_utils.py", line 22, in __getitem__
    return self.store[self.normalize(uri)]
KeyError: 'https://devicetree.org/meta-schemas/core.yaml'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 777, in resolve_from_url
    document = self.resolve_remote(url)
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 863, in resolve_remote
    with urlopen(uri) as url:
  File "/usr/lib/python3.6/urllib/request.py", line 223, in urlopen
    return opener.open(url, data, timeout)
  File "/usr/lib/python3.6/urllib/request.py", line 532, in open
    response = meth(req, response)
  File "/usr/lib/python3.6/urllib/request.py", line 642, in http_response
    'http', request, response, code, msg, hdrs)
  File "/usr/lib/python3.6/urllib/request.py", line 564, in error
    result = self._call_chain(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 504, in _call_chain
    result = func(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 756, in http_error_302
    return self.parent.open(new, timeout=req.timeout)
  File "/usr/lib/python3.6/urllib/request.py", line 532, in open
    response = meth(req, response)
  File "/usr/lib/python3.6/urllib/request.py", line 642, in http_response
    'http', request, response, code, msg, hdrs)
  File "/usr/lib/python3.6/urllib/request.py", line 570, in error
    return self._call_chain(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 504, in _call_chain
    result = func(*args)
  File "/usr/lib/python3.6/urllib/request.py", line 650, in http_error_default
    raise HTTPError(req.full_url, code, msg, hdrs, fp)
urllib.error.HTTPError: HTTP Error 404: Not Found

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 34, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 557, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 517, in process_schema
    DTValidator.check_schema(schema)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 668, in check_schema
    meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py", line 779, in resolve_from_url
    raise exceptions.RefResolutionError(exc)
jsonschema.exceptions.RefResolutionError: HTTP Error 404: Not Found
Documentation/devicetree/bindings/Makefile:53: recipe for target 'Documentation/devicetree/bindings/processed-schema.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/processed-schema.yaml] Error 123
make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema.yaml'
Documentation/devicetree/bindings/Makefile:49: recipe for target 'Documentation/devicetree/bindings/processed-schema-examples.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/processed-schema-examples.yaml] Error 123
make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema-examples.yaml'
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1337735

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.


Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01685C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90DB206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFKT0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:26:04 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:55616 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbgFKT0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:26:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 96FAF1807D68E;
        Thu, 11 Jun 2020 19:26:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: roll92_3811c9926dd6
X-Filterd-Recvd-Size: 10445
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jun 2020 19:26:01 +0000 (UTC)
Message-ID: <42da4b47dd3aaee77e65550df30e548dd23580cd.camel@perches.com>
Subject: Re: [PATCH] .clang-format: update column limit
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jun 2020 12:26:00 -0700
In-Reply-To: <CANiq72=58t3T0VckOOm7jAnwaxdEK2zbrWeQw-bXifmOq86BCA@mail.gmail.com>
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
         <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
         <CANiq72=BbGqXmiG8+1QuJnLXMTwNjUg9WuWR9eJcLMHZ=k5hQw@mail.gmail.com>
         <4c6f8d63817cbc51765fd0b3046f81dccbd17ec7.camel@perches.com>
         <CANiq72nOaDo9LQ3JoZk6VH-ZYErHpvD1O=DyVngs3xno5e9W7Q@mail.gmail.com>
         <b4646ed22573568c0953d272514ab3b701e54faa.camel@perches.com>
         <CANiq72=58t3T0VckOOm7jAnwaxdEK2zbrWeQw-bXifmOq86BCA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-11 at 20:51 +0200, Miguel Ojeda wrote:
> On Thu, Jun 11, 2020 at 6:22 PM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2020-06-11 at 13:54 +0200, Miguel Ojeda wrote:
> > > Why is 80 "still preferred" to begin with?
> > 
> > That's neither my nor your issue to solve.
[]
> By the way, I noticed that a lot of kernel code will still trigger the
> 100-column warning (~20% of the previous set triggering it!).
> 
> Cheers,
> Miguel

Hey again Miguel:

A little script and some statistics:

Today about 6% of all code lines are > 80 columns

Oddities like the ~3% of all lines with 113 and 121 columns
are machine generated.

So realistically, < 3% of code is > 80 columns.

Separate out whatever subsystems you like on the first line:

$ git ls-files -- '*.[ch]' | \
  xargs expand | \
  awk '{ print length($0);}' | \
  sort -n | uniq -c | \
  awk '{array[NR] = $0; count[NR] = $1; sum += $1;} END { total = 0; for (i = 1; i <= NR; i++) { total += count[i]; printf "%s %.2f\n", array[i], total / sum * 100;}}'  
awk: cmd. line:1: (FILENAME=- FNR=4440107) warning: Invalid multibyte data detected. There may be a mismatch between your data and your locale.
3455770 0 13.23
1157486 1 17.66
 574694 2 19.86
 280390 3 20.93
  31446 4 21.05
  29545 5 21.17
  73717 6 21.45
   7345 7 21.48
  13018 8 21.53
 476703 9 23.35
 180246 10 24.04
 143531 11 24.59
  68625 12 24.85
  26514 13 24.95
  72634 14 25.23
  73967 15 25.51
 248466 16 26.47
 384157 17 27.94
 189412 18 28.66
 268797 19 29.69
 201788 20 30.46
 173988 21 31.13
 310914 22 32.32
 268757 23 33.35
 251725 24 34.31
 378764 25 35.76
 297660 26 36.90
 314712 27 38.10
 310217 28 39.29
 254886 29 40.27
 331904 30 41.54
 346239 31 42.86
 263004 32 43.87
 345515 33 45.19
 330351 34 46.46
 315555 35 47.67
 324772 36 48.91
 292872 37 50.03
 331934 38 51.30
 312446 39 52.50
 296784 40 53.63
 327897 41 54.89
 317866 42 56.10
 308287 43 57.28
 328277 44 58.54
 294287 45 59.67
 320852 46 60.90
 297384 47 62.03
 297185 48 63.17
 311184 49 64.36
 300313 50 65.51
 290202 51 66.62
 297554 52 67.76
 285576 53 68.85
 326253 54 70.10
 294160 55 71.23
 269516 56 72.26
 289752 57 73.37
 275687 58 74.43
 263747 59 75.44
 275174 60 76.49
 254685 61 77.46
 256117 62 78.44
 261010 63 79.44
 264508 64 80.46
 265899 65 81.47
 244046 66 82.41
 240534 67 83.33
 236809 68 84.23
 236241 69 85.14
 235128 70 86.04
 258164 71 87.03
 217702 72 87.86
 266741 73 88.88
 219092 74 89.72
 204094 75 90.50
 194298 76 91.25
 226122 77 92.11
 168129 78 92.75
 169807 79 93.40
 112483 80 93.83
  35581 81 93.97
  27556 82 94.08
  25829 83 94.18
  24490 84 94.27
  26327 85 94.37
  58577 86 94.59
  19372 87 94.67
  15753 88 94.73
  19481 89 94.80
  13913 90 94.86
  36455 91 95.00
  58113 92 95.22
   8095 93 95.25
  11709 94 95.29
   6739 95 95.32
   5893 96 95.34
   6817 97 95.37
   5830 98 95.39
   5285 99 95.41
   4815 100 95.43
   5381 101 95.45
   4000 102 95.47
   5510 103 95.49
  82742 104 95.80
   2980 105 95.81
   4189 106 95.83
   2637 107 95.84
   2341 108 95.85
  89130 109 96.19
  13856 110 96.24
   2155 111 96.25
   2342 112 96.26
 337926 113 97.55
 131165 114 98.06
   8816 115 98.09
   1746 116 98.10
  81835 117 98.41
   5505 118 98.43
   1572 119 98.44
   1572 120 98.44
 378537 121 99.89
   1353 122 99.90
   1873 123 99.90
   1597 124 99.91
   1468 125 99.92
   1119 126 99.92
    843 127 99.92
    878 128 99.93
    834 129 99.93
    686 130 99.93
    771 131 99.94
    646 132 99.94
    698 133 99.94
    756 134 99.94
    400 135 99.95
    535 136 99.95
    362 137 99.95
    303 138 99.95
   1785 139 99.96
    400 140 99.96
    336 141 99.96
    407 142 99.96
    281 143 99.96
    291 144 99.96
    418 145 99.97
    245 146 99.97
    255 147 99.97
    343 148 99.97
    196 149 99.97
    165 150 99.97
    269 151 99.97
    190 152 99.97
    206 153 99.97
    339 154 99.97
    168 155 99.97
    174 156 99.98
    221 157 99.98
    149 158 99.98
    262 159 99.98
    243 160 99.98
    127 161 99.98
    101 162 99.98
    161 163 99.98
    153 164 99.98
    190 165 99.98
    119 166 99.98
     74 167 99.98
    185 168 99.98
    128 169 99.98
     54 170 99.98
    114 171 99.98
    104 172 99.98
     51 173 99.98
    113 174 99.98
    227 175 99.99
     66 176 99.99
     50 177 99.99
     99 178 99.99
     35 179 99.99
    106 180 99.99
     57 181 99.99
     36 182 99.99
     44 183 99.99
    225 184 99.99
     26 185 99.99
     55 186 99.99
     56 187 99.99
    417 188 99.99
     26 189 99.99
    104 190 99.99
     50 191 99.99
     94 192 99.99
     37 193 99.99
     16 194 99.99
     19 195 99.99
     36 196 99.99
     13 197 99.99
     15 198 99.99
     28 199 99.99
     50 200 99.99
     16 201 99.99
     23 202 99.99
      8 203 99.99
     10 204 99.99
     39 205 99.99
     17 206 99.99
     32 207 99.99
     72 208 99.99
     14 209 99.99
     15 210 99.99
     24 211 99.99
      6 212 99.99
     12 213 99.99
     36 214 99.99
     12 215 99.99
     17 216 99.99
     33 217 99.99
      6 218 99.99
      8 219 99.99
     18 220 99.99
      5 221 99.99
      5 222 99.99
      9 223 99.99
      5 224 99.99
      8 225 99.99
      5 226 99.99
      4 227 99.99
     11 228 99.99
      4 229 99.99
      3 230 99.99
      1 231 99.99
     20 232 99.99
      8 233 99.99
      8 234 99.99
     12 235 99.99
      5 236 99.99
     13 237 99.99
      5 238 99.99
      4 239 99.99
     13 240 99.99
    275 241 100.00
      3 242 100.00
      5 243 100.00
      7 244 100.00
     11 245 100.00
     13 246 100.00
      3 247 100.00
      9 248 100.00
      3 249 100.00
      6 250 100.00
      4 251 100.00
      1 252 100.00
      3 253 100.00
      3 254 100.00
      8 255 100.00
      3 256 100.00
      1 257 100.00
      1 258 100.00
      1 259 100.00
      6 260 100.00
      1 261 100.00
      1 262 100.00
      3 263 100.00
      2 264 100.00
      3 265 100.00
      3 266 100.00
      4 267 100.00
     10 268 100.00
     16 269 100.00
    132 270 100.00
      8 271 100.00
      1 272 100.00
      5 273 100.00
      1 274 100.00
     20 275 100.00
      2 276 100.00
      9 277 100.00
      1 278 100.00
      1 279 100.00
      2 280 100.00
      1 281 100.00
      8 282 100.00
      4 283 100.00
      4 284 100.00
     10 285 100.00
      1 286 100.00
      5 287 100.00
      2 288 100.00
      2 289 100.00
      1 290 100.00
      5 291 100.00
      2 292 100.00
      1 293 100.00
      3 294 100.00
      3 295 100.00
      2 296 100.00
      1 297 100.00
      1 298 100.00
    550 299 100.00
      1 300 100.00
      7 301 100.00
      6 302 100.00
      8 303 100.00
      4 304 100.00
      4 305 100.00
      1 306 100.00
      3 308 100.00
      1 309 100.00
      3 310 100.00
      1 314 100.00
      1 315 100.00
      1 316 100.00
      1 317 100.00
      1 318 100.00
      2 319 100.00
      3 320 100.00
      4 321 100.00
      2 323 100.00
      2 326 100.00
     13 327 100.00
     10 328 100.00
      2 329 100.00
      2 330 100.00
      2 331 100.00
      1 332 100.00
      2 334 100.00
      3 337 100.00
      1 338 100.00
      1 340 100.00
      2 341 100.00
      2 343 100.00
      1 344 100.00
      2 345 100.00
      1 346 100.00
      1 347 100.00
      1 348 100.00
      1 350 100.00
      2 352 100.00
      3 353 100.00
      2 354 100.00
      1 356 100.00
      2 362 100.00
      1 363 100.00
      1 364 100.00
      2 365 100.00
      1 371 100.00
      2 372 100.00
      2 373 100.00
      1 383 100.00
      1 386 100.00
      1 394 100.00
      1 395 100.00
      2 397 100.00
      1 398 100.00
      1 400 100.00
      1 402 100.00
      3 405 100.00
      1 414 100.00
      2 418 100.00
      1 419 100.00
      1 422 100.00
      1 440 100.00
      2 441 100.00
      1 442 100.00
      1 444 100.00
      1 452 100.00
      1 462 100.00
      1 464 100.00
      1 479 100.00
      1 480 100.00
      1 481 100.00
      1 492 100.00
      1 497 100.00
      1 501 100.00
      1 502 100.00
      1 503 100.00
      1 504 100.00
      1 510 100.00
      1 511 100.00
      2 517 100.00
      1 531 100.00
      1 534 100.00
      1 535 100.00
      1 539 100.00
      1 543 100.00
      1 544 100.00
      1 590 100.00
      1 608 100.00
      1 631 100.00
      1 702 100.00
      1 704 100.00
      1 712 100.00
      1 730 100.00
      1 733 100.00
      1 784 100.00
      1 790 100.00
      1 809 100.00
      1 823 100.00
      1 880 100.00
      1 901 100.00
      1 905 100.00
      1 947 100.00
      1 979 100.00
      1 1034 100.00
      1 1052 100.00
      1 1061 100.00
      1 1204 100.00
      5 1214 100.00
      1 1215 100.00
      2 1319 100.00

